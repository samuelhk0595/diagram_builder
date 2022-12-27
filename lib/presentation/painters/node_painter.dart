import 'dart:ui' as ui;

import 'package:diagram_builder/presentation/model/node_model.dart';
import 'package:diagram_builder/utils/path_creator.dart';
import 'package:flutter/material.dart';

class NodeLinkPainter extends CustomPainter {
  NodeLinkPainter({
    required this.nodes,
    required this.canvasPosition,
    this.pathCretor,

  });

  final List<NodeModel> nodes;
  final PathCreator? pathCretor;
  final Offset canvasPosition;

  @override
  void paint(Canvas canvas, Size size) {
    if (nodes.isEmpty) return;
    const pointMode = ui.PointMode.polygon;
    final paint = Paint()
      ..color = const Color(0xff79D594)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    for (final originNode in nodes) {
      for (final linkable in originNode.linkables) {
        if (linkable.targetNodeId != null) {
          final targetNode =
              nodes.singleWhere((node) => node.id == linkable.targetNodeId);

          final originPoint = linkable.originPoint;
          final points = pathCretor?.linkPoints(
                origin: originPoint.translate(canvasPosition.dx * -1, canvasPosition.dy * -1),
                target: targetNode.targetPoint.translate(canvasPosition.dx * -1, canvasPosition.dy * -1),
              ) ??
              [originNode.originPoint.translate(canvasPosition.dx * -1, canvasPosition.dy * -1), originNode.targetPoint.translate(canvasPosition.dx * -1, canvasPosition.dy * -1)];

          canvas.drawPoints(pointMode, [...points], paint);

          final arrowPath = buildArrowPath(targetNode.targetPoint.translate(canvasPosition.dx * -1, canvasPosition.dy * -1));
          canvas.drawPath(arrowPath, paint);
        }
      }
    }
  }

  Path buildArrowPath(Offset arrowheadPosition) {
    arrowheadPosition = arrowheadPosition.translate(2, 0);
    final path = Path();
    path.moveTo(arrowheadPosition.dx, arrowheadPosition.dy);
    path.lineTo(arrowheadPosition.dx - 20, arrowheadPosition.dy - 7);
    path.quadraticBezierTo(arrowheadPosition.dx -15, arrowheadPosition.dy,
    arrowheadPosition.dx - 20, arrowheadPosition.dy + 7,
    );
    path.lineTo(arrowheadPosition.dx, arrowheadPosition.dy);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
