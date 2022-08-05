import 'dart:ui' as ui;

import 'package:diagram_builder/presentation/model/node_model.dart';
import 'package:diagram_builder/utils/path_creator.dart';
import 'package:flutter/material.dart';

class NodeLinkPainter extends CustomPainter {
  NodeLinkPainter({
    required this.nodes,
    this.pathCretor,
  });

  final List<NodeModel> nodes;
  final PathCreator? pathCretor;

  @override
  void paint(Canvas canvas, Size size) {
    if (nodes.isEmpty) return;
    const pointMode = ui.PointMode.polygon;
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    for (final originNode in nodes) {
      if (originNode.targetId != null) {
        final targetNode =
            nodes.singleWhere((node) => node.id == originNode.targetId);

        final points = pathCretor?.linkPoints(
              origin: originNode.originPoint,
              target: targetNode.targetPoint,
            ) ??
            [originNode.originPoint, originNode.targetPoint];

        canvas.drawPoints(pointMode, [...points], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}