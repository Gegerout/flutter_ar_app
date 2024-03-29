import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:collection/collection.dart';

class RealTimeUpdatesScreen extends StatefulWidget {
  const RealTimeUpdatesScreen({super.key});

  @override
  State<RealTimeUpdatesScreen> createState() {
    return _RealTimeUpdatesScreenState();
  }
}

class _RealTimeUpdatesScreenState extends State<RealTimeUpdatesScreen> {
  late ARKitController arkitController;
  ARKitNode? movingNode;
  bool busy = false;

  @override
  void dispose() {
    arkitController.updateAtTime = null;
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Real Time Updates Sample'),
      ),
      child: ARKitSceneView(
        onARKitViewCreated: _onARKitViewCreated,
      ),
    );
  }

  void _onARKitViewCreated(ARKitController arkitController) {
    final material = ARKitMaterial(
      diffuse: ARKitMaterialProperty.color(CupertinoColors.white),
    );

    final sphere = ARKitSphere(
      materials: [material],
      radius: 0.01,
    );

    movingNode = ARKitNode(
      geometry: sphere,
      position: vector.Vector3(0, 0, -0.25),
    );

    this.arkitController = arkitController;
    this.arkitController.updateAtTime = (time) {
      if (busy == false) {
        busy = true;
        this.arkitController.performHitTest(x: 0.25, y: 0.75).then((results) {
          if (results.isNotEmpty) {
            final point = results.firstWhereOrNull(
              (o) => o.type == ARKitHitTestResultType.featurePoint,
            );
            if (point == null) {
              return;
            }
            final position = vector.Vector3(
              point.worldTransform.getColumn(3).x,
              point.worldTransform.getColumn(3).y,
              point.worldTransform.getColumn(3).z,
            );
            final newNode = ARKitNode(
              geometry: sphere,
              position: position,
            );
            this.arkitController.remove(movingNode!.name);
            movingNode = null;
            this.arkitController.add(newNode);
            movingNode = newNode;
          }
          busy = false;
        });
      }
    };

    this.arkitController.add(movingNode!);
  }
}
