import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class FaceDetectionScreen extends StatefulWidget {
  const FaceDetectionScreen({super.key});

  @override
  State<FaceDetectionScreen> createState() {
    return _FaceDetectionScreenState();
  }
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  late ARKitController arkitController;
  final happyPlayer = AudioPlayer();
  final sadPlayer = AudioPlayer();
  ARKitNode? node;

  ARKitNode? leftEye;
  ARKitNode? rightEye;

  String emotion = "";

  @override
  void dispose() {
    happyPlayer.dispose();
    sadPlayer.dispose();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar:
            const CupertinoNavigationBar(middle: Text('Face Detection Sample')),
        child: Stack(
          children: [
            ARKitSceneView(
              configuration: ARKitConfiguration.faceTracking,
              onARKitViewCreated: onARKitViewCreated,
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Text(
                  emotion,
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .textStyle
                      .copyWith(
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.white),
                ))
          ],
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    happyPlayer.setAsset("assets/audio/happy.mp3");
    sadPlayer.setAsset("assets/audio/sad.mp3");
    happyPlayer.setLoopMode(LoopMode.all);
    sadPlayer.setLoopMode(LoopMode.all);
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is! ARKitFaceAnchor) {
      return;
    }
    final material = ARKitMaterial(fillMode: ARKitFillMode.lines);
    anchor.geometry.materials.value = [material];

    node = ARKitNode(geometry: anchor.geometry);
    arkitController.add(node!, parentNodeName: anchor.nodeName);

    leftEye = _createEye(anchor.leftEyeTransform);
    arkitController.add(leftEye!, parentNodeName: anchor.nodeName);
    rightEye = _createEye(anchor.rightEyeTransform);
    arkitController.add(rightEye!, parentNodeName: anchor.nodeName);
  }

  ARKitNode _createEye(Matrix4 transform) {
    final position = vector.Vector3(
      transform.getColumn(3).x,
      transform.getColumn(3).y,
      transform.getColumn(3).z,
    );
    final material = ARKitMaterial(
      diffuse: ARKitMaterialProperty.color(CupertinoColors.systemYellow),
    );
    final sphere = ARKitBox(
        materials: [material], width: 0.03, height: 0.03, length: 0.03);

    return ARKitNode(geometry: sphere, position: position);
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitFaceAnchor && mounted) {
      final faceAnchor = anchor;
      final smile = faceAnchor.blendShapes["mouthSmile_L"] ?? 0;
      // final jaw = faceAnchor.blendShapes["jawOpen"] ?? 0;
      // final mouse = faceAnchor.blendShapes["mouseUpperUpRight"] ?? 0;
      // if(mouse > 0.5) {
      //   setState(() {
      //     emotion = "Angry";
      //   });
      // }
      // else if(jaw > 0.5) {
      //   setState(() {
      //     emotion = "Surprised";
      //   });
      // }
      if (smile > 0.5) {
        sadPlayer.stop();
        happyPlayer.play();
        setState(() {
          emotion = "Happy";
        });
      } else if (smile < 0.00001) {
        happyPlayer.stop();
        sadPlayer.play();
        setState(() {
          emotion = "Sad";
        });
      } else {
        sadPlayer.stop();
        happyPlayer.stop();
        setState(() {
          emotion = "";
        });
      }
      arkitController.updateFaceGeometry(node!, anchor.identifier);
      _updateEye(leftEye!, faceAnchor.leftEyeTransform,
          faceAnchor.blendShapes['eyeBlink_L'] ?? 0);
      _updateEye(rightEye!, faceAnchor.rightEyeTransform,
          faceAnchor.blendShapes['eyeBlink_R'] ?? 0);
    }
  }

  void _updateEye(ARKitNode node, Matrix4 transform, double blink) {
    final scale = vector.Vector3(1, 1 - blink, 1);
    node.scale = scale;
  }
}
