import 'package:diagram_builder/presentation/model/linkable_entity.dart';
import 'package:flutter/material.dart';

class LinkableModel extends LinkableEntity {
  LinkableModel({
    required super.id,
    required super.nodeId,
    super.targetNodeId,
  }) : super(key: GlobalKey());

  RenderBox get _renderBox =>
      key.currentContext!.findRenderObject() as RenderBox;

  @override
  Offset get originPoint =>
      _renderBox.localToGlobal(_renderBox.paintBounds.centerRight);
      
}
