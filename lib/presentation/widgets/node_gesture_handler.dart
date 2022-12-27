import 'package:flutter/material.dart';

class NodeGestureHandler extends StatefulWidget {
  const NodeGestureHandler(
      {required this.child, this.onDragUpdate, this.onTap, super.key});

  final void Function(Offset newPosition)? onDragUpdate;
  final void Function()? onTap;
  final Widget child;

  @override
  State<NodeGestureHandler> createState() => _NodeGestureHandlerState();
}

class _NodeGestureHandlerState extends State<NodeGestureHandler> {
  Offset localPosition = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onPanStart: (details) {
        localPosition = details.localPosition;
      },
      onPanUpdate: (details) {
        if (widget.onDragUpdate != null) {
          widget.onDragUpdate!(details.delta);
        }
      },
      child: widget.child,
    );
  }
}
