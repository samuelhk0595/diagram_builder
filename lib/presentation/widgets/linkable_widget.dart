import 'package:diagram_builder/diagram_builder.dart';
import 'package:diagram_builder/presentation/pages/diagram_view_model.dart';
import 'package:flutter/material.dart';

class LinkableWidget extends StatelessWidget {
  const LinkableWidget({
    super.key,
    required this.node,
    required this.builder,
  });

  final NodeModel node;
  final WidgetBuilder builder;

  DiagramViewModel get viewModel => DiagramViewModel.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        builder(context),
        GestureDetector(
            onPanDown: (details) {
              viewModel.startCursorPath(
                  originNode: node, position: details.globalPosition);
            },
            onPanUpdate: (details) {
              viewModel.updateCursorPath(details.globalPosition);
            },
            onPanEnd: (details) {
              viewModel.stopCursorPath();
            },
            child: defaultDragPoint(const Offset(-10, 0))),
      ],
    );
  }

  Widget defaultDragPoint([Offset translateOffset = Offset.zero]) {
    return Transform.translate(
      offset: translateOffset,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white)),
      ),
    );
  }
}
