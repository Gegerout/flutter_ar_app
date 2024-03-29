import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:arkit_plugin/arkit_plugin.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() {
    return _VideoScreenState();
  }
}

class _VideoScreenState extends State<VideoScreen> {
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
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar:
            const CupertinoNavigationBar(middle: Text('Video Sample')),
        child: Stack(
          children: [
            ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CupertinoButton.filled(
                    padding: const EdgeInsets.all(16),
                    child: Icon(_isPlaying
                        ? CupertinoIcons.pause
                        : CupertinoIcons.play_arrow),
                    onPressed: () async {
                      if (_isPlaying) {
                        await _video.pause();
                      } else {
                        await _video.play();
                      }
                      setState(() => _isPlaying = !_isPlaying);
                    }),
              ),
            )
          ],
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    _video = ARKitMaterialProperty.video(
        width: 640,
        height: 380,
        url:
            "https://drive.usercontent.google.com/u/0/uc?id=1zGK-Ss9TIY9_FrreCTls3J3bfC-ICMLX&export=download");
    final material = ARKitMaterial(
      diffuse: _video,
      doubleSided: true,
    );

    final plane = ARKitPlane(width: 0.5, height: 0.25, materials: [material]);

    final node = ARKitNode(geometry: plane);
    node.eulerAngles = vector.Vector3(0, 0, math.pi);

    this.arkitController.add(node);
  }
}
