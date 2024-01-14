import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LoadModelScreen extends StatefulWidget {
  const LoadModelScreen({super.key});

  @override
  State<LoadModelScreen> createState() => _LoadModelScreenState();
}

class _LoadModelScreenState extends State<LoadModelScreen> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar:
            const CupertinoNavigationBar(middle: Text('Load .gltf or .glb')),
        child: ARKitSceneView(
          showFeaturePoints: true,
          enableTapRecognizer: true,
          planeDetection: ARPlaneDetection.horizontalAndVertical,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onARTap = (ar) {
      final point = ar.firstWhereOrNull(
        (o) => o.type == ARKitHitTestResultType.featurePoint,
      );
      if (point != null) {
        _onARTapHandler(point);
      }
    };
  }

  void _onARTapHandler(ARKitTestResult point) {
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

    final node = _getNodeFromFlutterAsset(position);
    arkitController.add(node);
  }

  ARKitGltfNode _getNodeFromFlutterAsset(vector.Vector3 position) =>
      ARKitGltfNode(
        assetType: AssetType.flutterAsset,
        url: 'assets/models/hutao.glb',
        scale: vector.Vector3(0.05, 0.05, 0.05),
        position: position,
      );
}
