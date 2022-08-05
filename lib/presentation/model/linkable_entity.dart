import 'package:flutter/material.dart';

abstract class LinkableEntity {
  LinkableEntity({
    required this.key,
    required this.id,
    required this.nodeId,
    this.targetNodeId,
  });

  final String nodeId;
  final GlobalKey key;
  Offset get originPoint;
  final String id;
  String? targetNodeId;
}
