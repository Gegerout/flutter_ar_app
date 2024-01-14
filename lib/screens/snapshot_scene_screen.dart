import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../utils/ar_helper.dart';

class SnapshotSceneScreen extends StatefulWidget {
  const SnapshotSceneScreen({super.key});

  @override
  State<SnapshotSceneScreen> createState() {
    return _SnapshotSceneScreenState();
  }
}

class _SnapshotSceneScreenState extends State<SnapshotSceneScreen> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Snapshot'),
      ),
      child: Stack(
        children: [
          ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
          Align(
            alignment: Alignment.bottomRight,
            child: CupertinoButton(
                child: const Icon(CupertinoIcons.camera_fill),
                onPressed: () async {
                  try {
                    final image = await arkitController.snapshot();
                    if (context.mounted) {
                      await Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => SnapshotPreview(
                            imageProvider: image,
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                }),
          )
        ],
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.add(createSphere());
  }
}

class SnapshotPreview extends StatelessWidget {
  const SnapshotPreview({
    Key? key,
    required this.imageProvider,
  }) : super(key: key);

  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Image Preview'),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(image: imageProvider),
        ],
      ),
    );
  }
}
