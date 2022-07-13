import 'package:diagram_builder/presentation/pages/diagram_view_model.dart';
import 'package:diagram_builder/presentation/widgets/node_gesture_handler.dart';
import 'package:diagram_builder/presentation/widgets/node_positioner.dart';
import 'package:diagram_builder/presentation/widgets/node_widget.dart';
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

  @override
  void initState() {
    super.initState();
    viewModel.nodes = widget.nodes;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel,
      builder: (context, snapshot, _) {
        return CustomPaint(
          child: Container(
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
        );
      },
    );
  }
}
