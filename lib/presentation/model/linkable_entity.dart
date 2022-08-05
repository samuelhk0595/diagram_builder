import 'package:flutter/material.dart';

abstract class LinkableEntity {
  LinkableEntity({
    required this.key,
    required this.id,
  });

  final GlobalKey key;
  Offset get originPoint;
  final String id;
}
