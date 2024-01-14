import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart';

class PanoramaScreen extends StatefulWidget {
  const PanoramaScreen({super.key});

  @override
  State<PanoramaScreen> createState() {
    return _PanoramaScreenState();
  }
}

class _PanoramaScreenState extends State<PanoramaScreen> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar:
            const CupertinoNavigationBar(middle: Text('Panorama Sample')),
        child: ARKitSceneView(
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
