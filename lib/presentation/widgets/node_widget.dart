import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  const NodeWidget({
    super.key,
    required this.onDragEnd,
    required this.onDragStart,
    required this.onDragUpdate,
    required this.builder,
  });

  final void Function(DragUpdateDetails details) onDragUpdate;
  final void Function(DragDownDetails details) onDragStart;
  final void Function(DragEndDetails details) onDragEnd;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        defaultDragPoint(const Offset(5, 0)),
        builder(context),
        GestureDetector(
            onPanDown: onDragStart,
            onPanEnd: onDragEnd,
            onPanUpdate: onDragUpdate,
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
