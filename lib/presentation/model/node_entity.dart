import 'package:diagram_builder/presentation/model/linkable_entity.dart';
import 'package:flutter/cupertino.dart';

abstract class NodeEntity {
  NodeEntity({
    required this.id,
    required this.position,
    required this.builder,
    required this.key,
    required this.linkables,
    this.onNodeTap,
  });
  final String id;
  final Widget Function(BuildContext context, List<LinkableEntity> linkables)
      builder;
  final GlobalKey key;
  void Function(String nodeId)? onNodeTap;
  List<LinkableEntity> linkables;
  Offset position;
  

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
