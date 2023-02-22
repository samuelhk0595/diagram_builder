import 'package:diagram_builder/presentation/pages/diagram_view_model.dart';
import 'package:flutter/material.dart';

class LinkableWidget extends StatelessWidget {
  const LinkableWidget({
    required super.key,
    required this.id,
    required this.child,
    required this.nodeId,
  })  : topKey = null,
        bottomKey = null,
        bottomId = null;

  const LinkableWidget.doubled({
    // super.key,
    required String topId,
    required String bottomId,
    required this.child,
    required this.nodeId,
    required GlobalKey topKey,
    required GlobalKey bottomKey,
  })  : topKey = topKey,
        bottomKey = bottomKey,
        bottomId = bottomId,
        id = topId;

  final String? bottomId;
  final String id;
  final Widget child;
  final String nodeId;
  final GlobalKey? topKey;
  final GlobalKey? bottomKey;

  DiagramViewModel get viewModel => DiagramViewModel.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        Column(
          children: [
            GestureDetector(
                key: topKey,
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
            if (bottomId != null)
              Column(
                children: [
                  const SizedBox(height: 15),
                  GestureDetector(
                      key: bottomKey,
                      onPanDown: (details) {
                        viewModel.startCursorPath(
                          nodeId: nodeId,
                          position: details.globalPosition,
                          linkableId: bottomId!,
                        );
                      },
                      onPanUpdate: (details) {
                        viewModel.updateCursorPath(details.globalPosition);
                      },
                      onPanEnd: (details) {
                        viewModel.stopCursorPath();
                      },
                      child: defaultDragPoint(const Offset(-0, 0), Colors.red)),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget defaultDragPoint(
      [Offset translateOffset = Offset.zero, Color? color]) {
    return Transform.translate(
      offset: translateOffset,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            color: color ?? Colors.green,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white)),
      ),
    );
  }
}
