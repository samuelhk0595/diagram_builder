import 'package:flutter/cupertino.dart';

abstract class NodeEntity {
  NodeEntity({
    required this.id,
    required this.position,
    this.targetId,
  });
  final String id;
  Offset position;
  String? targetId;

  Offset get targetPoint;
  Offset get originPoint;
}

extension OffsetExtension on Offset {
  double computeDistance(Offset other) {
    double distanceX = dx - other.dx;
    if (distanceX.isNegative) distanceX = distanceX * (-1);
    double distanceY = dy - other.dy;
    if (distanceY.isNegative) distanceY = distanceY * (-1);
    return distanceX + distanceY;
  }
}
