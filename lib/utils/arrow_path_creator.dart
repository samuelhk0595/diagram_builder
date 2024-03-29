import 'package:diagram_builder/presentation/model/path_model.dart';
import 'package:diagram_builder/utils/path_creator.dart';
import 'package:flutter/material.dart';

class ArrowPathCreator extends PathCreator {
  @override
  List<Offset> generatePoints(PathModel path) {
    final points = [path.origin];

    // double module = path.target.dx - path.origin.dx;
    // if (module < 0) module = (module * -1);

    // final originHeightPoint = Offset(module / 2, path.origin.dy);
    // points.add(originHeightPoint);
    points.add(path.target);
    return points;

    switch (getRelativeTargetPosition(
        originOffset: path.origin, targetOffset: path.target)) {
      case TargetNodePosition.diagonalTopLeft:
        points.add(Offset(path.origin.dx, path.target.dy));
        points.add(path.target);
        break;
      case TargetNodePosition.diagonalBottomLeft:
        points.add(Offset(path.origin.dx, path.target.dy));
        points.add(path.target);
        break;
      case TargetNodePosition.diagonalTopRight:
        points.add(Offset(path.origin.dx, path.target.dy));
        points.add(path.target);
        break;
      case TargetNodePosition.diagonalBottomRight:
        points.add(Offset(path.origin.dx, path.target.dy));
        points.add(path.target);
        break;

      default:
        points.add(path.target);
        break;
    }

    return points;
  }

  TargetNodePosition? getRelativeTargetPosition({
    required Offset originOffset,
    required Offset targetOffset,
  }) {
    if (originOffset.dx < targetOffset.dx &&
        originOffset.dy > targetOffset.dy) {
      print(TargetNodePosition.diagonalTopRight.toString());
      return TargetNodePosition.diagonalTopRight;
    }
    if (originOffset.dx < targetOffset.dx &&
        originOffset.dy < targetOffset.dy) {
      print(TargetNodePosition.diagonalBottomRight.toString());
      return TargetNodePosition.diagonalBottomRight;
    }
    if (originOffset.dx > targetOffset.dx &&
        originOffset.dy > targetOffset.dy) {
      print(TargetNodePosition.diagonalTopLeft.toString());
      return TargetNodePosition.diagonalTopLeft;
    }
    if (originOffset.dx > targetOffset.dx &&
        originOffset.dy < targetOffset.dy) {
      print(TargetNodePosition.diagonalBottomLeft.toString());
      return TargetNodePosition.diagonalBottomLeft;
    }
  }

  @override
  List<Offset> linkPoints({required Offset origin, required Offset target}) {
    return [origin, target];
  }
}

enum TargetNodePosition {
  diagonalTopLeft,
  diagonalBottomLeft,
  diagonalTopRight,
  diagonalBottomRight,
}
