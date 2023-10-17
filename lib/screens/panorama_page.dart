import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class PanoramaPage extends StatefulWidget {
  const PanoramaPage({super.key});

  @override
  State<PanoramaPage> createState() {
    return _PanoramaPageState();
  }
}

class _PanoramaPageState extends State<PanoramaPage> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Panorama Sample')),
    body: ARKitSceneView(
      onARKitViewCreated: onARKitViewCreated,
    ),
  );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    final material = ARKitMaterial(
      diffuse: ARKitMaterialProperty.image('assets/images/world.jpg'),
      doubleSided: true,
    );
    final sphere = ARKitSphere(
      materials: [material],
      radius: 1,
    );

    final node = ARKitNode(
      geometry: sphere,
      position: Vector3.zero(),
      eulerAngles: Vector3.zero(),
    );
    this.arkitController.add(node);
  }
}