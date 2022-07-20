import 'package:flutter/material.dart';

import 'presentation/model/node_model.dart';
import 'presentation/pages/diagram_builder_page.dart';

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
      body: DiagramBuilder(nodes: nodes,
      onNodeLinking: (originNode, targetNode){
        print(originNode.id);
        print(targetNode.id);
      },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNode,
        child: const Icon(Icons.add),
      ),
    );
  }

  void addNode() {
    final key = GlobalKey();
    final node = NodeModel(
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          color: Colors.blue,
          child: Text(key.hashCode.toString()),
        );
      },
      key: key,
      id: key.hashCode.toString(),
      position: Offset.zero,
    );
    nodes[node.id] = node;
    setState(() {});
  }
}
