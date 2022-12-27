import 'package:diagram_builder/presentation/model/linkable_model.dart';
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
  // NodeModel? originNode;
  LinkableModel? currentLink;
  final widgetKey = GlobalKey();

  void Function(NodeModel originNode, NodeModel targetNode, String linkableId)?
      onNodeLinking;
  void Function(NodeModel originNode, String linkableId, Offset position)?
      onPointerReleaseWithoutLinking;

  void addNode(NodeModel node) {
    nodes[node.id] = node;
    notifyListeners();
  }

  void linkNodes(NodeModel originNode, String linkableId, String targetNodeId) {
    final linkableIndex =
        originNode.linkables.indexWhere((element) => element.id == linkableId);

    originNode.linkables[linkableIndex].targetNodeId = targetNodeId;
    nodes[originNode.id] = originNode;
    final targetNode = nodes[targetNodeId];
    if (onNodeLinking != null) {
      onNodeLinking!(
          originNode, targetNode!, originNode.linkables[linkableIndex].id);
    }
    notifyListeners();
  }

  void updateNodePosition({
    required String nodeId,
    required Offset newPosition,
  }) {
    nodes[nodeId]!.position =
        nodes[nodeId]!.position.translate(newPosition.dx, newPosition.dy);
    notifyListeners();
  }

  void startCursorPath({
    required Offset position,
    required String nodeId,
    required String linkableId,
  }) {
    final renderBox = widgetKey.currentContext!.findRenderObject() as RenderBox;
    final canvasPosition = renderBox.localToGlobal(Offset.zero);

    position = position.translate(canvasPosition.dx * -1, canvasPosition.dy * -1);

    final originNode = nodes[nodeId];
    currentLink = originNode!.linkables
        .singleWhere((element) => element.id == linkableId) as LinkableModel;
    cursorPath = PathModel(origin: position, target: position);
    notifyListeners();
  }

  void updateCursorPath(Offset position) {
    final renderBox = widgetKey.currentContext!.findRenderObject() as RenderBox;
    final canvasPosition = renderBox.localToGlobal(Offset.zero);

    position = position.translate(canvasPosition.dx * -1, canvasPosition.dy * -1);
    
    cursorPath!.target = position;
    notifyListeners();
  }

  void stopCursorPath() {
    paths.add(cursorPath!);
    final originNode = nodes[currentLink!.nodeId];
    final nodeDistances = nodes.values
        .map((node) => NodeDistanceModel(
            node: node,
            distance: node.targetPoint.computeDistance(cursorPath!.target)))
        .toList();
    nodeDistances.sort((a, b) => a.distance.compareTo(b.distance));
    final hittableTargets = nodeDistances
        .where((element) =>
            element.node.id != originNode!.id && element.distance < 50)
        .toList();
    if (hittableTargets.isNotEmpty) {
      final linkableIndex = originNode!.linkables
          .indexWhere((element) => element.id == currentLink!.id);

      originNode.linkables[linkableIndex].targetNodeId =
          hittableTargets.first.node.id;

      if (onNodeLinking != null) {
        onNodeLinking!(nodes[originNode.id]!, hittableTargets.first.node,
            originNode.linkables[linkableIndex].id);
      }
    }
    if (onPointerReleaseWithoutLinking != null) {
      if (hittableTargets.isEmpty) {
        onPointerReleaseWithoutLinking!(
            originNode!, currentLink!.id, cursorPath!.target);
      }
    }
    cursorPath = null;
    currentLink = null;
    notifyListeners();
  }

  void updateCursorPosition(Offset position) {
    cursorPosition = position;
    notifyListeners();
  }
}
