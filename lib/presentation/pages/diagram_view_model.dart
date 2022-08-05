import 'package:diagram_builder/presentation/model/node_distance_model.dart';
import 'package:diagram_builder/presentation/model/node_entity.dart';
import 'package:diagram_builder/presentation/model/node_model.dart';
import 'package:diagram_builder/presentation/model/path_model.dart';
import 'package:flutter/cupertino.dart';

class DiagramViewModel extends ValueNotifier {
  factory DiagramViewModel() {
    return instance;
  }

  DiagramViewModel._internal() : super(0);

  static final instance = DiagramViewModel._internal();

  Map<String, NodeModel> nodes = {};
  List<PathModel> paths = [];
  PathModel? cursorPath;
  Offset cursorPosition = Offset.zero;
  NodeModel? originNode;

  void Function(NodeModel originNode, NodeModel targetNode)? onNodeLinking;

  void updateNodePosition({
    required String nodeId,
    required Offset position,
  }) {
    nodes[nodeId]!.position = position;
    notifyListeners();
  }

  void startCursorPath({
    required Offset position,
    required NodeModel originNode,
  }) {
    this.originNode = originNode;
    cursorPath = PathModel(origin: position, target: position);
    notifyListeners();
  }

  void updateCursorPath(Offset position) {
    cursorPath!.target = position;
    notifyListeners();
  }

  void stopCursorPath() {
    paths.add(cursorPath!);

    final nodeDistances = nodes.values
        .map((node) => NodeDistanceModel(
            node: node,
            distance: node.targetPoint.computeDistance(cursorPath!.target)))
        .toList();
    nodeDistances.sort((a, b) => a.distance.compareTo(b.distance));
    final possibleTargets = nodeDistances
        .where((element) => element.node.id != originNode!.id)
        .toList();
    // final possibleTargets = nodeDistances.where((node) => node.distance < 50);
    if (possibleTargets.isNotEmpty) {
      nodes[originNode!.id]!.targetId = possibleTargets.first.node.id;
      if (onNodeLinking != null) {
        onNodeLinking!(nodes[originNode!.id]!, possibleTargets.first.node);
      }
    }
    cursorPath = null;
    originNode = null;
    notifyListeners();
  }

  void updateCursorPosition(Offset position) {
    cursorPosition = position;
    notifyListeners();
  }
}
