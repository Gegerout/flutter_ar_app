import 'package:ar_app/screens/face_detection_screen.dart';
import 'package:ar_app/screens/widget_projection_screen.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("AR App"),
        ),
        // body: ARKitSceneView(
        //     onARKitViewCreated: (controller) => arView(controller)),
        //body: const WidgetProjectionPage(),
        body: const FaceDetectionPage(),
      ),
    );
  }

  void arView(ARKitController controller) {
    final nodeAr = ARKitNode(
        geometry: ARKitSphere(materials: [
      ARKitMaterial(
          diffuse: ARKitMaterialProperty.image("assets/images/world.jpg"),
          doubleSided: true)
    ], radius: 1), position: Vector3(0,0,0));
    controller.add(nodeAr);
  }
}
