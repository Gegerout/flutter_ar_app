import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class PhysicsScreen extends StatefulWidget {
  const PhysicsScreen({super.key});

  @override
  State<PhysicsScreen> createState() {
    return _PhysicsScreenState();
  }
}

class _PhysicsScreenState extends State<PhysicsScreen> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
      navigationBar:
          const CupertinoNavigationBar(middle: Text('Physics Sample')),
      child: ARKitSceneView(onARKitViewCreated: onARKitViewCreated));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    _addPlane(this.arkitController);
    _addSphere(this.arkitController);
  }

  void _addSphere(ARKitController controller) {
    final material = ARKitMaterial(
        diffuse: ARKitMaterialProperty.color(CupertinoColors.systemBlue));
    final sphere = ARKitSphere(materials: [material], radius: 0.1);
    final node = ARKitNode(
        geometry: sphere,
        physicsBody: ARKitPhysicsBody(
          ARKitPhysicsBodyType.dynamicType,
          categoryBitMask: BodyType.sphere.index + 1,
        ),
        position: vector.Vector3(0, 1, -1));
    controller.add(node);
  }

  void _addPlane(ARKitController controller) {
    final plane = ARKitPlane(
      width: 2,
      height: 2,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty.color(CupertinoColors.systemGreen),
        )
      ],
    );
    final node = ARKitNode(
      geometry: plane,
      physicsBody: ARKitPhysicsBody(
        ARKitPhysicsBodyType.staticType,
        shape: ARKitPhysicsShape(plane),
        categoryBitMask: BodyType.plane.index + 1,
      ),
      rotation: vector.Vector4(1, 0, 0, -math.pi / 2),
      position: vector.Vector3(0, -0.5, -1),
    );
    controller.add(node);
  }
}

enum BodyType { sphere, plane }
