import 'dart:ui' as ui;

import 'package:diagram_builder/presentation/model/path_model.dart';
import 'package:diagram_builder/utils/path_creator.dart';
import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  ArrowPainter({
    required this.paths,
    this.pathCretor,
  });

  final List<PathModel> paths;
  final PathCreator? pathCretor;

  @override
  void paint(Canvas canvas, Size size) {
    if (paths.isEmpty) return;
    const pointMode = ui.PointMode.polygon;

    final points = pathCretor?.generatePoints(paths.first) ??
        [paths.first.origin, paths.first.target];

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);

    for (final point in points) {
      TextSpan span =
          TextSpan(style: TextStyle(color: Colors.red), text: point.toString());
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, point);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
