import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import '../models/screen_model.dart';
import 'change_icon_screen.dart';
import 'earth_screen.dart';
import 'hello_world_screen.dart';
import 'panorama_page.dart';
import 'physics_screen.dart';
import 'plane_detection_screen.dart';
import 'positioned_video_screen.dart';
import 'real_time_updates_screen.dart';
import 'snapshot_scene_screen.dart';
import 'tap_screen.dart';
import 'video_screen.dart';
import 'widget_projection_screen.dart';
import 'package:flutter/material.dart';
import 'body_tracking_screen.dart';
import 'custom_animation_screen.dart';
import 'custom_object_screen.dart';
import 'distance_tracking_screen.dart';
import 'face_detection_screen.dart';
import 'load_model_screen.dart';
import 'manipulation_screen.dart';
import 'measure_screen.dart';
import 'occlusion_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final samples = [
      ScreenModel(
        'Hello World',
        'The simplest scene with all geometries.',
        Icons.home,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const HelloWorldScreen())),
      ),
      ScreenModel(
        'Tap',
        'Sphere which handles tap event.',
        Icons.touch_app,
        () => Navigator.of(context)
            .push<void>(CupertinoPageRoute(builder: (c) => const TapScreen())),
      ),
      ScreenModel(
        'Plane Detection',
        'Detects horizontal plane.',
        Icons.blur_on,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const PlaneDetectionScreen())),
      ),
      ScreenModel(
        'Measure',
        'Measures distances',
        Icons.linear_scale,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const MeasureScreen())),
      ),
      ScreenModel(
        'Physics',
        'A sphere and a plane with dynamic and static physics',
        Icons.file_download,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const PhysicsScreen())),
      ),
      ScreenModel(
        'Occlusion',
        'Spheres which are not visible after horizontal and vertical planes.',
        Icons.blur_circular,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const OcclusionScreen())),
      ),
      ScreenModel(
        'Manipulation',
        'Custom objects with pinch and rotation events.',
        Icons.threed_rotation,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const ManipulationScreen())),
      ),
      ScreenModel(
        'Face Tracking',
        'Face mask sample.',
        Icons.face,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const FaceDetectionScreen())),
      ),
      ScreenModel(
        'Body Tracking',
        'Dash that follows your hand.',
        Icons.person,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const BodyTrackingScreen())),
      ),
      ScreenModel(
        'Panorama',
        '360 photo sample.',
        Icons.panorama,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const PanoramaScreen())),
      ),
      ScreenModel(
        'Video',
        'Video on plane',
        Icons.videocam,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const VideoScreen())),
      ),
      ScreenModel(
        'Positioned video',
        'Positioned video on plane',
        Icons.videocam,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const PositionedVideoScreen())),
      ),
      ScreenModel(
        'Widget Projection',
        'Flutter widgets in AR',
        Icons.widgets,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const WidgetProjectionScreen())),
      ),
      ScreenModel(
        'Real Time Updates',
        'Calls a function once per frame',
        Icons.timer,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const RealTimeUpdatesScreen())),
      ),
      ScreenModel(
        'Snapshot',
        'Make a photo of AR content',
        Icons.camera,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const SnapshotSceneScreen())),
      ),
      ScreenModel(
        'Custom Object',
        'Place custom object on plane with coaching overlay.',
        Icons.nature,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const CustomObjectScreen())),
      ),
      ScreenModel(
        'Load .gltf or .glb',
        'Load .gltf or .glb from the Flutter assets or the Documents folder',
        Icons.folder_copy,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const LoadModelScreen())),
      ),
      ScreenModel(
        'Custom Animation',
        'Custom object animation. Port of https://github.com/eh3rrera/ARKitAnimation',
        Icons.accessibility_new,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const CustomAnimationScreen())),
      ),
      ScreenModel(
        'Earth',
        'Sphere with an image texture and rotation animation.',
        Icons.language,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const EarthScreen())),
      ),
      ScreenModel(
        'Distance tracking',
        'Detects horizontal plane and track distance on it.',
        Icons.blur_on,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const DistanceTrackingScreen())),
      ),
      ScreenModel(
        'Change icon',
        'Changes app icon',
        Icons.app_registration,
        () => Navigator.of(context).push<void>(
            CupertinoPageRoute(builder: (c) => const ChangeIconScreen())),
      )
    ];

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        leading: SvgPicture.asset(
          "assets/icon/icon_new_red.svg",
          colorFilter:
              const ColorFilter.mode(Color(0xFFFF2C00), BlendMode.srcIn),
          semanticsLabel: 'A red up arrow',
          height: 32,
          width: 32,
        ),
        middle: const Text("AR App"),
      ),
      // navigationBar: CupertinoNavigationBar(
      //   title: Row(
      //     children: [
      //       SvgPicture.asset("assets/icon/icon_new_red.svg",
      //         colorFilter:
      //         const ColorFilter.mode(Color(0xFFFF2C00), BlendMode.srcIn),
      //         semanticsLabel: 'A red up arrow', height: 32, width: 32,),
      //       const SizedBox(width: 16,),
      //       const Text('AR App')
      //     ],
      //   ),
      // ),
      // body: ListView(
      //     children: samples
      //         .map((s) => Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 20),
      //               child: ScreenCard(item: s),
      //             ))
      //         .toList()),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: CupertinoFormSection.insetGrouped(
                children: samples
                    .map((e) => GestureDetector(
                          onTap: e.onTap,
                          child: CupertinoFormRow(
                            padding: const EdgeInsets.all(20),
                            prefix: Text(e.title),
                            child: Container(),
                          ),
                        ))
                    .toList()),
          ),
        ),
      ),
    );
  }
}
