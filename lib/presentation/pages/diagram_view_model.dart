import 'package:diagram_builder/presentation/model/node_model.dart';
import 'package:flutter/cupertino.dart';

class DiagramViewModel extends ValueNotifier{
  DiagramViewModel():super(0);

  Map<String,NodeModel> nodes = {};

void updateNodePosition({
    required String nodeId,
    required Offset position,
  }) {
    final node = nodes[nodeId];
    node!.position = position;
    notifyListeners();
  }

}