import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class TapScreen extends StatefulWidget {
  const TapScreen({super.key});

  @override
  State<TapScreen> createState() {
    return _TapScreenState();
  }
}

class _TapScreenState extends State<TapScreen> {
  late ARKitController arkitController;
  ARKitSphere? sphere;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar:
            const CupertinoNavigationBar(middle: Text('Tap Gesture Sample')),
        child: ARKitSceneView(
          enableTapRecognizer: true,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onNodeTap = (nodes) => onNodeTapHandler(nodes);

    final material = ARKitMaterial(
        diffuse: ARKitMaterialProperty.color(CupertinoColors.systemYellow));
    sphere = ARKitSphere(
      materials: [material],
      radius: 0.1,
    );

    final node = ARKitNode(
      name: 'sphere',
      geometry: sphere,
      position: vector.Vector3(0, 0, -0.5),
    );
    this.arkitController.add(node);
  }

  void onNodeTapHandler(List<String> nodesList) {
    final name = nodesList.first;
    final color =
        (sphere!.materials.value!.first.diffuse as ARKitMaterialColor).color ==
                CupertinoColors.systemYellow
            ? CupertinoColors.systemBlue
            : CupertinoColors.systemYellow;
    sphere!.materials.value = [
      ARKitMaterial(diffuse: ARKitMaterialProperty.color(color))
    ];
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) =>
          CupertinoPopupSurface(child: Text('You tapped on $name')),
    );
  }
}
