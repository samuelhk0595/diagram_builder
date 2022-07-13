import 'package:flutter/material.dart';

class NodeGestureHandler extends StatelessWidget {
  const NodeGestureHandler({required this.child, this.onDragUpdate, super.key});

  final void Function(Offset position)? onDragUpdate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final newPosition = details.globalPosition.translate(-30, 0);
        if (onDragUpdate != null) onDragUpdate!(newPosition);
      },
      child: child,
    );
  }
}
