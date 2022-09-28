import 'package:diagram_builder/diagram_builder.dart';
import 'package:diagram_builder/presentation/model/path_model.dart';
import 'package:diagram_builder/presentation/pages/diagram_view_model.dart';
import 'package:diagram_builder/presentation/painters/arrow_painter.dart';
import 'package:diagram_builder/presentation/painters/node_painter.dart';
import 'package:diagram_builder/presentation/widgets/node_gesture_handler.dart';
import 'package:diagram_builder/presentation/widgets/node_positioner.dart';
import 'package:diagram_builder/utils/arrow_path_creator.dart';
import 'package:flutter/material.dart';

class DiagramBuilder<T> extends StatefulWidget {
  const DiagramBuilder({
    Key? key,
    this.width = 1920,
    this.height = 1080,
    this.nodes = const {},
    this.onNodeLinking,
    this.onNodePositionUpdate,
    this.onPointerReleaseWithoutLinking,
    this.overlays,
    this.onCreated,
  }) : super(key: key);

  final double width;
  final double height;
  final Map<String, NodeModel> nodes;
  final void Function(NodeModel originNode, NodeModel targetNode)?
      onNodeLinking;
  final void Function(
    NodeModel originNode,
  )? onNodePositionUpdate;

  final void Function(NodeModel originNode, String linkableId, Offset position)?
      onPointerReleaseWithoutLinking;
  final List<DiagramOverlay>? overlays;
  final void Function(DiagramController controller)? onCreated;

  @override
  State<DiagramBuilder> createState() => _DiagramBuilderState();
}

class _DiagramBuilderState extends State<DiagramBuilder> {
  @override
  void initState() {
    super.initState();

    viewModel.nodes = widget.nodes;
    viewModel.onNodeLinking = widget.onNodeLinking;
    viewModel.onPointerReleaseWithoutLinking =
        widget.onPointerReleaseWithoutLinking;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.onCreated != null) {
        widget.onCreated!(DiagramController.create(viewModel));
      }
    });
  }

  final pathCreator = ArrowPathCreator();
  DiagramViewModel get viewModel => DiagramViewModel.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff3A3D5C),
      child: MouseRegion(
        onHover: (details) {
          viewModel.updateCursorPosition(details.position);
        },
        child: AnimatedBuilder(
          animation: viewModel,
          builder: (context, _) {
            return Stack(
              children: [
                Positioned(
                  left: viewModel.cursorPath?.target.dx ?? 0.0,
                  top: viewModel.cursorPath?.target.dy ?? 0.0,
                  child: Container(),
                ),
                CustomPaint(
                  foregroundPainter: NodeLinkPainter(
                    pathCretor: pathCreator,
                    nodes: viewModel.nodes.values.toList(),
                  ),
                  painter: ArrowPainter(pathCretor: pathCreator, paths: [
                    PathModel(
                      origin: viewModel.cursorPath?.origin ?? Offset.zero,
                      target: viewModel.cursorPath?.target ?? Offset.zero,
                    ),
                  ]),
                  child: SizedBox(
                    width: widget.width,
                    height: widget.height,
                    child: Stack(
                        children: viewModel.nodes.values.map((node) {
                      return NodePositioner(
                        offset: node.position,
                        key: node.key,
                        child: NodeGestureHandler(
                            onDragUpdate: (position) {
                              viewModel.updateNodePosition(
                                nodeId: node.id,
                                position: position,
                              );
                              if (widget.onNodePositionUpdate != null) {
                                widget.onNodePositionUpdate!(node);
                              }
                            },
                            child: node.builder(context, node.linkables)),
                      );
                    }).toList()),
                  ),
                ),
                if (widget.overlays != null)
                  ...widget.overlays!.map<Widget>((overlay) {
                    return Positioned(
                      left: overlay.position.dx,
                      top: overlay.position.dy,
                      child: overlay.builder(context),
                    );
                  }).toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
