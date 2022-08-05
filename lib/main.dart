import 'package:diagram_builder/presentation/model/linkable_model.dart';
import 'package:flutter/material.dart';

import 'presentation/model/node_model.dart';
import 'presentation/pages/diagram_builder_page.dart';
import 'presentation/widgets/linkable_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DiagramPage());
  }
}

class DiagramPage extends StatefulWidget {
  const DiagramPage({Key? key}) : super(key: key);

  @override
  State<DiagramPage> createState() => _DiagramPageState();
}

class _DiagramPageState extends State<DiagramPage> {
  Map<String, NodeModel> nodes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DiagramBuilder(
        nodes: nodes,
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

  void addMultilinkingNode() {
    final key = GlobalKey();
    final nodeId = key.hashCode.toString();
    final node = NodeModel(
      linkables: [
        LinkableModel(
          id: '1',
          key: GlobalKey(),
          nodeId: nodeId,
        ),
        LinkableModel(
          id: '2',
          key: GlobalKey(),
          nodeId: nodeId,
        ),
      ],
      builder: (context, linkables) {
        return Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          color: Colors.blue,
          child: Column(
            children: [
              Text(key.hashCode.toString()),
              ...linkables
                  .map<Widget>(
                    (linkable) => LinkableWidget(
                        key: linkable.key,
                        id: linkable.id,
                        nodeId: key.hashCode.toString(),
                        child: Container(
                          color: Colors.pink,
                          width: 80,
                          height: 20,
                        )),
                  )
                  .toList()
            ],
          ),
        );
      },
      key: key,
      id: nodeId,
      position: Offset.zero,
    );
    nodes[node.id] = node;
    setState(() {});
  }

  addSingleLinkNode() {
    final key = GlobalKey();
    final nodeId = key.hashCode.toString();
    final node = NodeModel(
      linkables: [
        LinkableModel(
          id: '1',
          key: GlobalKey(),
          nodeId: nodeId,
        ),
      ],
      builder: (context, linkables) {
        final linkable = linkables.first;
        return LinkableWidget(
          nodeId: linkable.nodeId,
          id: linkable.id,
          key: linkable.key,
          child: Container(
            alignment: Alignment.center,
            width: 100,
            height: 100,
            color: Colors.blue,
            child: Text(key.hashCode.toString()),
          ),
        );
      },
      key: key,
      id: nodeId,
      position: Offset.zero,
    );
    nodes[node.id] = node;
    setState(() {});
  }
}
