import 'package:diagram_builder/presentation/model/node_model.dart';
import 'package:diagram_builder/presentation/model/path_model.dart';
import 'package:flutter/cupertino.dart';

class DiagramViewModel extends ValueNotifier {
  DiagramViewModel() : super(0);

  Map<String, NodeModel> nodes = {};
  List<PathModel> paths = [];

  Offset cursorPosition = Offset.zero;

  void updateNodePosition({
    required String nodeId,
    required Offset position,
  }) {
    final node = nodes[nodeId];
    node!.position = position;
    notifyListeners();
  }

  void updateCursorPosition(Offset position) {
    cursorPosition = position;
    notifyListeners();
  }
}
