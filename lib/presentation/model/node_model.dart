import 'package:diagram_builder/presentation/model/linkable_model.dart';
import 'package:flutter/cupertino.dart';

import 'node_entity.dart';

class NodeModel extends NodeEntity {
  NodeModel({
    required super.id,
    required super.position,
    required super.builder,
    required List<LinkableModel> linkables,
    super.onNodeTap,
    super.freeGestureBuilder,
  }) : super(linkables: linkables, key: GlobalKey());

  RenderBox get _renderBox =>
      key.currentContext!.findRenderObject() as RenderBox;

  Size get widgetSize => _renderBox.size;

  @override
  Offset get originPoint =>
      _renderBox.localToGlobal(_renderBox.paintBounds.centerRight);

  @override
  Offset get targetPoint =>
      _renderBox.localToGlobal(_renderBox.paintBounds.centerLeft);
}
