import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() {
    return _VideoPageState();
  }
}

class _VideoPageState extends State<VideoPage> {
  late ARKitController arkitController;
  late ARKitMaterialVideo _video;
  bool _isPlaying = true;

  @override
  void dispose() {
    _video.dispose();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Video Sample')),
      body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_isPlaying) {
            await _video.pause();
          } else {
            await _video.play();
          }
          setState(() => _isPlaying = !_isPlaying);
        },
        child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    _video = ARKitMaterialProperty.video(
      width: 640,
      height: 380,
      url: "https://drive.usercontent.google.com/u/0/uc?id=1zGK-Ss9TIY9_FrreCTls3J3bfC-ICMLX&export=download"
    );
    final material = ARKitMaterial(
      diffuse: _video,
      doubleSided: true,
    );

    final sphere = ARKitSphere(materials: [material], radius: 1);
    final plane = ARKitPlane(width: 0.5, height: 0.25, materials: [material]);

    final node = ARKitNode(geometry: plane);
    //node.eulerAngles = vector.Vector3(0, 0, math.pi); // rotate the node

    this.arkitController.add(node);
  }
}