import 'package:diagram_builder/diagram_builder.dart';

abstract class NodeFactory<T> {
  NodeModel buildNode(T source);

  Type get nodeType => T;
}
