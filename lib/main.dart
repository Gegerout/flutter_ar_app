import 'package:ar_app/screens/face_detection_screen.dart';
import 'package:ar_app/screens/manipulation_screen.dart';
import 'package:ar_app/screens/measure_screen.dart';
import 'package:ar_app/screens/occlusion_screen.dart';
import 'package:ar_app/screens/panorama_page.dart';
import 'package:ar_app/screens/physics_screen.dart';
import 'package:ar_app/screens/plane_detection_screen.dart';
import 'package:ar_app/screens/real_time_updates_screen.dart';
import 'package:ar_app/screens/snapshot_scene_screen.dart';
import 'package:ar_app/screens/tap_screen.dart';
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
        //body: const FaceDetectionPage(),
        //body: const ManipulationPage(),
        //body: const MeasurePage(),
        //body: const OcclusionPage(),
        //body: const PanoramaPage(),
        //body: const PhysicsPage(),
        //body: const PlaneDetectionPage(),
        //body: const RealTimeUpdatesPage()
        //body: const SnapshotScenePage(),
        body: const TapPage(),
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
