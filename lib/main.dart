import 'package:diagram_builder/presentation/model/linkable_model.dart';
import 'package:diagram_builder/presentation/widgets/diagram_overlay.dart';
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
      home: const DiagramPage(),
      // home: const DiagramFactoryDemoPage(),
    );
  }
}

class DiagramPage extends StatefulWidget {
  const DiagramPage({Key? key}) : super(key: key);

  @override
  State<DiagramPage> createState() => _DiagramPageState();
}

class _DiagramPageState extends State<DiagramPage> {
  Map<String, NodeModel> nodes = {};
  List<DiagramOverlay> overlays = [];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: DiagramBuilder(
        nodes: nodes,
        overlays: overlays,
        width: screenSize.width * 2,
        height: screenSize.height * 2,
        onNodeLinking: (originNode, targetNode, linkableId) {
          print(originNode.id);
          print(targetNode.id);
          print(linkableId);
        },
        onNodePositionUpdate: (node) {
          print('${node.id}  ${node.position}');
        },
        onPointerReleaseWithoutLinking: (originNode, linkableId, position) {
          addOverlay(position);
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
    final nodeId = DateTime.now().toString();
    final node = NodeModel(
      linkables: [
        LinkableModel(
          id: '1',
          nodeId: nodeId,
        ),
        LinkableModel(
          id: '2',
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
              Text(nodeId),
              ...linkables
                  .map<Widget>(
                    (linkable) => LinkableWidget(
                        key: linkable.key,
                        id: linkable.id,
                        nodeId: linkable.nodeId,
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
      id: nodeId,
      position: Offset.zero,
    );
    nodes[node.id] = node;
    setState(() {});
  }

  addSingleLinkNode() {
    final nodeId = DateTime.now().toString();
    final node = NodeModel(
      linkables: [
        LinkableModel(
          id: '1',
          nodeId: nodeId,
        ),
      ],
      builder: (context, linkables) {
        final linkable = linkables.first;
        return LinkableWidget(
          key: linkable.key,
          id: linkable.id,
          nodeId: linkable.nodeId,
          child: Container(
            alignment: Alignment.center,
            width: 100,
            height: 100,
            color: Colors.blue,
            child: Text(nodeId),
          ),
        );
      },
      id: nodeId,
      position: Offset.zero,
    );
    nodes[node.id] = node;
    setState(() {});
  }

  addOverlay(Offset position) {
    final overlay = DiagramOverlay(
        builder: (context) {
          return InkWell(
              onTap: () {
                overlays.clear();
                setState(() {});
              },
              child: Card(
                color: Colors.blue,
                elevation: 10.0,
                child: Container(width: 200, height: 300),
              ));
        },
        position: position);

    overlays.add(overlay);
    setState(() {});
  }
}
