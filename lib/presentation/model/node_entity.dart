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
}


