import 'package:diagram_builder/diagram_builder.dart';

abstract class NodeFactory<T> {
  NodeModel build(T item);
}
