import 'package:flutter/cupertino.dart';

class DiagramOverlay {
  const DiagramOverlay({
    required this.builder,
    required this.position,
  });
  final Offset position;
  final WidgetBuilder builder;
}
