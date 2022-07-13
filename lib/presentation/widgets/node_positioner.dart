import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NodePositioner extends ParentDataWidget<StackParentData> {
  final Offset offset;

  const NodePositioner({
    required super.child,
    required this.offset,
    super.key,
  });

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is StackParentData);
    final StackParentData parentData =
        renderObject.parentData! as StackParentData;
    bool needsLayout = false;

    if (parentData.left != offset.dx) {
      parentData.left = offset.dx;
      needsLayout = true;
    }

    if (parentData.top != offset.dy) {
      parentData.top = offset.dy;
      needsLayout = true;
    }

    // if (parentData.width != width) {
    //   parentData.width = width;
    //   needsLayout = true;
    // }

    // if (parentData.height != height) {
    //   parentData.height = height;
    //   needsLayout = true;
    // }

    if (needsLayout) {
      final AbstractNode? targetParent = renderObject.parent;
      if (targetParent is RenderObject) targetParent.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Stack;
}
