// import 'dart:math' as math;
// import 'package:vector_math/vector_math_64.dart' as vector;
//
// import 'package:arkit_plugin/arkit_plugin.dart';
// import 'package:flutter/material.dart';
//
// class VideoPage extends StatefulWidget {
//   const VideoPage({super.key});
//
//   @override
//   State<VideoPage> createState() {
//     return _VideoPageState();
//   }
// }
//
// class _VideoPageState extends State<VideoPage> {
//   late ARKitController arkitController;
//   late ARKitMaterialVideo _video;
//   bool _isPlaying = true;
//
//   @override
//   void dispose() {
//     _video.dispose();
//     arkitController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(title: const Text('Video Sample')),
//       body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           if (_isPlaying) {
//             await _video.pause();
//           } else {
//             await _video.play();
//           }
//           setState(() => _isPlaying = !_isPlaying);
//         },
//         child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
//       ));
//
//   void onARKitViewCreated(ARKitController arkitController) {
//     this.arkitController = arkitController;
//
//     _video = ARKitMaterialProperty.video(
//       width: 640,
//       height: 380,
//       url: "https://drive.usercontent.google.com/u/0/uc?id=1zGK-Ss9TIY9_FrreCTls3J3bfC-ICMLX&export=download"
//     );
//     final material = ARKitMaterial(
//       diffuse: _video,
//       doubleSided: true,
//     );
//
//     final sphere = ARKitSphere(materials: [material], radius: 1);
//     final plane = ARKitPlane(width: 0.5, height: 0.25, materials: [material]);
//
//     final node = ARKitNode(geometry: plane);
//     node.eulerAngles = vector.Vector3(0, 0, math.pi); // rotate the node
//
//     this.arkitController.add(node);
//   }
// }
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
  late VideoPlayerController _controller;
  bool _isPlaying = true;
  String anchorId = '';
  double x = 0, y = 0;
  double width = 1, height = 1;
  Matrix4 transform = Matrix4.identity();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://drive.usercontent.google.com/u/0/uc?id=1zGK-Ss9TIY9_FrreCTls3J3bfC-ICMLX&export=download'))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    arkitController.onAddNodeForAnchor = null;
    arkitController.onUpdateNodeForAnchor = null;
    _video.dispose();
    _controller.dispose();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Video Sample')),
      body: Stack(
        children: [
          ARKitSceneView(
            trackingImagesGroupName: 'AR Resources',
            onARKitViewCreated: onARKitViewCreated,
            worldAlignment: ARWorldAlignment.camera,
            configuration: ARKitConfiguration.imageTracking,
          ),
          Positioned(
              left: x,
              top: y,
              child: Container(
                  transform: transform,
                  width: width,
                  height: height,
                  child: VideoPlayer(_controller)))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_isPlaying) {
            //await _video.pause();
            _controller.pause();
          } else {
            //await _video.play();
            _controller.play();
          }
          setState(() => _isPlaying = !_isPlaying);
        },
        child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;

    // _video = ARKitMaterialProperty.video(
    //     width: 1920,
    //     height: 1080,
    //     url:
    //         "https://drive.usercontent.google.com/u/0/uc?id=1zGK-Ss9TIY9_FrreCTls3J3bfC-ICMLX&export=download");
    // final material = ARKitMaterial(
    //   diffuse: _video,
    //   doubleSided: true,
    // );
    //
    // final sphere = ARKitSphere(materials: [material], radius: 1);
    // final plane = ARKitPlane(width: 0.5, height: 0.25, materials: [material]);
    //
    // final node = ARKitNode(geometry: plane);
    // node.eulerAngles = vector.Vector3(0, 0, math.pi); // rotate the node
    //
    // this.arkitController.add(node);
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      anchorId = anchor.identifier;
      _updatePosition(anchor);
      _updateRotation(anchor);
    }
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor.identifier == anchorId && anchor is ARKitImageAnchor) {
      _updatePosition(anchor);
      _updateRotation(anchor);
    }
  }

  Future _updateRotation(ARKitAnchor anchor) async {
    final t = anchor.transform.clone();
    t.invertRotation();
    t.rotateZ(math.pi / 2);
    t.rotateX(math.pi / 2);
    setState(() {
      transform = t;
    });
  }

  Future _updatePosition(ARKitImageAnchor anchor) async {
    final transform = anchor.transform;
    final width = anchor.referenceImagePhysicalSize.x / 2;
    final height = anchor.referenceImagePhysicalSize.y / 2;

    final topRight = vector.Vector4(width, 0, -height, 1)
      ..applyMatrix4(transform);
    final bottomRight = vector.Vector4(width, 0, height, 1)
      ..applyMatrix4(transform);
    final bottomLeft = vector.Vector4(-width, 0, -height, 1)
      ..applyMatrix4(transform);
    final topLeft = vector.Vector4(-width, 0, height, 1)
      ..applyMatrix4(transform);

    final pointsWorldSpace = [topRight, bottomRight, bottomLeft, topLeft];

    final pointsViewportSpace = pointsWorldSpace.map(
        (p) => arkitController.projectPoint(vector.Vector3(p.x, p.y, p.z)));
    final pointsViewportSpaceResults = await Future.wait(pointsViewportSpace);

    setState(() {
      x = pointsViewportSpaceResults[2]!.x;
      y = pointsViewportSpaceResults[2]!.y;
      this.width = pointsViewportSpaceResults[0]!
          .distanceTo(pointsViewportSpaceResults[3]!);
      this.height = pointsViewportSpaceResults[1]!
          .distanceTo(pointsViewportSpaceResults[2]!);
    });
  }
}
