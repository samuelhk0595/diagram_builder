import 'package:diagram_builder/presentation/model/path_model.dart';
import 'package:diagram_builder/presentation/pages/diagram_view_model.dart';
import 'package:diagram_builder/presentation/painters/arrow_painter.dart';
import 'package:diagram_builder/presentation/widgets/node_gesture_handler.dart';
import 'package:diagram_builder/presentation/widgets/node_positioner.dart';
import 'package:diagram_builder/presentation/widgets/node_widget.dart';
import 'package:diagram_builder/utils/arrow_path_creator.dart';
import 'package:flutter/material.dart';

import '../model/node_model.dart';

class DiagramBuilder extends StatefulWidget {
  const DiagramBuilder({
    Key? key,
    this.width = 1920,
    this.height = 1080,
    this.nodes = const {},
  }) : super(key: key);

  final double width;
  final double height;
  final Map<String, NodeModel> nodes;

  @override
  State<DiagramBuilder> createState() => _DiagramBuilderState();
}

class _DiagramBuilderState extends State<DiagramBuilder> {
  final viewModel = DiagramViewModel();
  final pathCreator = ArrowPathCreator();

  @override
  void initState() {
    super.initState();
    viewModel.nodes = widget.nodes;
  }

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
                  left: viewModel.cursorPosition.dx,
                  top: viewModel.cursorPosition.dy,
                  child: Container(),
                ),
                CustomPaint(
                  foregroundPainter: ArrowPainter(
                    pathCretor: pathCreator,
                    paths: viewModel.paths,
                  ),
                  painter: ArrowPainter(pathCretor: pathCreator, paths: [
                    PathModel(
                      origin: const Offset(720, 450),
                      target: viewModel.cursorPosition,
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
                          },
                          child: const NodeWidget(),
                        ),
                      );
                    }).toList()),
                  ),
                ),
                Positioned(
                    left: 400,
                    top: 400,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
