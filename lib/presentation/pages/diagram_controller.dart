import '../model/node_model.dart';
import 'diagram_view_model.dart';

class DiagramController {
  DiagramController();
  DiagramController.create(DiagramViewModel viewModel) : _viewModel = viewModel;

  DiagramViewModel? _viewModel;

  void addNode(NodeModel node) {
    _viewModel?.addNode(node);
  }

  void linkNodes(NodeModel originNode,String linkableId, String targetNodeId) {
    _viewModel?.linkNodes(originNode,linkableId, targetNodeId);
  }
}
