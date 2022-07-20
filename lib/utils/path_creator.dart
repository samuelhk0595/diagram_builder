import 'package:diagram_builder/presentation/model/path_model.dart';
import 'package:flutter/cupertino.dart';

abstract class PathCreator {
  List<Offset> generatePoints(PathModel path);
  List<Offset> linkPoints({required Offset origin, required Offset target});
}
