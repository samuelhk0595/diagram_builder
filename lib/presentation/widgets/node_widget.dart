import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  const NodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
            onPanUpdate: (details) => print(details),
            child: defaultDragPoint(const Offset(5, 0))),
        Container(
          color: Colors.lightBlue,
          width: 100,
          height: 100,
        ),
        GestureDetector(
            onPanUpdate: (details) => print(details),
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
