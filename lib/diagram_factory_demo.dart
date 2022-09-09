import 'package:diagram_builder/diagram_builder.dart';
import 'package:flutter/material.dart';

class DiagramFactoryDemoPage extends StatefulWidget {
  const DiagramFactoryDemoPage({Key? key}) : super(key: key);

  @override
  State<DiagramFactoryDemoPage> createState() => _DiagramFactoryDemoPageState();
}

class _DiagramFactoryDemoPageState extends State<DiagramFactoryDemoPage> {
  Map<String, NodeModel> nodes = {};

  final items = <_SampleItem>[];
  final factories = <NodeFactory>[
    _BlueItemFactory(),
    _RedItemFactory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DiagramBuilder<_SampleItem>.factory(
        items: items,
        factories: factories,
        onNodeLinking: (originNode, targetNode) {
          print(originNode.id);
          print(targetNode.id);
        },
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: addMultilinkingNode,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: addSingleLinkNode,
            child: const Icon(Icons.add_a_photo),
          ),
        ],
      ),
    );
  }

  int id = 0;
  void addMultilinkingNode() {
    items.add(_BlueItem(id));
    id++;
    setState(() {});
  }

  addSingleLinkNode() {
    items.add(_RedItem(id));
    id++;
    setState(() {});
  }
}

abstract class _SampleItem {
  _SampleItem(this.id);
  final int id;
}

class _BlueItem extends _SampleItem {
  _BlueItem(super.id);
}

class _RedItem extends _SampleItem {
  _RedItem(super.id);
}

class _RedItemFactory extends NodeFactory<_RedItem> {
  @override
  NodeModel build(_RedItem source) {
    final nodeId = source.id.toString();
    return NodeModel(
      id: nodeId,
      position: Offset.zero,
      builder: ((context, linkables) {
        final linkable = linkables.first;
        return LinkableWidget(
          key: linkable.key,
          id: linkable.id,
          nodeId: linkable.nodeId,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        );
      }),
      linkables: [
        LinkableModel(id: '1', nodeId: nodeId),
      ],
    );
  }
}

class _BlueItemFactory extends NodeFactory<_BlueItem> {
  @override
  NodeModel build(_BlueItem source) {
    final nodeId = source.id.toString();
    return NodeModel(
      id: nodeId,
      position: Offset.zero,
      builder: ((context, linkables) {
        final linkable = linkables.first;
        return LinkableWidget(
          key: linkable.key,
          id: linkable.id,
          nodeId: linkable.nodeId,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Column(
                children: List.generate(
                    linkables.length,
                    (index) => LinkableWidget(
                          key: linkables[index].key,
                          id: linkables[index].id,
                          nodeId: linkables[index].nodeId,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: 50,
                            height: 50,
                            color: Colors.amber,
                          ),
                        ))),
          ),
        );
      }),
      linkables: [
        LinkableModel(id: '1', nodeId: nodeId),
        LinkableModel(id: '2', nodeId: nodeId),
      ],
    );
  }
}
