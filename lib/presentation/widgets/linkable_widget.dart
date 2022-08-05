import 'package:diagram_builder/presentation/pages/diagram_view_model.dart';
import 'package:flutter/material.dart';

class LinkableWidget extends StatelessWidget {
  const LinkableWidget({
    super.key,
    required this.nodeId,
    required this.child,
    required this.id,
  });

  final String id;
  final String nodeId;
  final Widget child;

  DiagramViewModel get viewModel => DiagramViewModel.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        GestureDetector(
            onPanDown: (details) {
              viewModel.startCursorPath(
                nodeId: nodeId,
                position: details.globalPosition,
                linkableId: id,
              );
            },
            onPanUpdate: (details) {
              viewModel.updateCursorPath(details.globalPosition);
            },
            onPanEnd: (details) {
              viewModel.stopCursorPath();
            },
            child: defaultDragPoint(const Offset(-0, 0))),
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
