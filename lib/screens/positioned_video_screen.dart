import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:video_player/video_player.dart';

class PositionedVideoScreen extends StatefulWidget {
  const PositionedVideoScreen({super.key});

  @override
  State<PositionedVideoScreen> createState() {
    return _PositionedVideoScreenState();
  }
}

class _PositionedVideoScreenState extends State<PositionedVideoScreen> {
  late ARKitController arkitController;
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
    _controller.dispose();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Video Sample')),
      child: Stack(
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
                  width: width * 1.2,
                  height: height,
                  child: VideoPlayer(_controller))),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomRight,
              child: CupertinoButton.filled(
                  padding: const EdgeInsets.all(16),
                  child: Icon(_isPlaying
                      ? CupertinoIcons.pause
                      : CupertinoIcons.play_arrow),
                  onPressed: () async {
                    if (_isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                    setState(() => _isPlaying = !_isPlaying);
                  }),
            ),
          )
        ],
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
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
