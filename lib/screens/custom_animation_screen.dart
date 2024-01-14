import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomAnimationScreen extends StatefulWidget {
  const CustomAnimationScreen({super.key});

  @override
  State<CustomAnimationScreen> createState() {
    return _CustomAnimationScreenState();
  }
}

class _CustomAnimationScreenState extends State<CustomAnimationScreen> {
  late ARKitController arkitController;
  ARKitReferenceNode? node;
  bool idle = true;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar:
            const CupertinoNavigationBar(middle: Text('Custom Animation')),
        child: Stack(
          children: [
            ARKitSceneView(
              showFeaturePoints: true,
              planeDetection: ARPlaneDetection.horizontal,
              onARKitViewCreated: onARKitViewCreated,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CupertinoButton(
                  child: Icon(
                      idle ? CupertinoIcons.play_arrow : CupertinoIcons.stop),
                  onPressed: () async {
                    if (idle) {
                      await arkitController.playAnimation(
                          key: 'dancing',
                          sceneName: 'model.scnassets/twist_danceFixed',
                          animationIdentifier: 'twist_danceFixed-1');
                    } else {
                      await arkitController.stopAnimation(key: 'dancing');
                    }
                    setState(() => idle = !idle);
                  }),
            )
          ],
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is! ARKitPlaneAnchor) {
      return;
    }
    _addPlane(arkitController, anchor);
  }

  void _addPlane(ARKitController? controller, ARKitPlaneAnchor anchor) {
    if (node != null) {
      controller?.remove(node!.name);
    }
    node = ARKitReferenceNode(
      url: 'model.scnassets/idleFixed.dae',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3(0.02, 0.02, 0.02),
    );
    controller?.add(node!, parentNodeName: anchor.nodeName);
  }
}
