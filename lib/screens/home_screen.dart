import 'package:ar_app/utils/screen_card.dart';
import '../models/screen_model.dart';
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
            MaterialPageRoute(builder: (c) => const HelloWorldScreen())),
      ),
      ScreenModel(
        'Tap',
        'Sphere which handles tap event.',
        Icons.touch_app,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => const TapScreen())),
      ),
      ScreenModel(
        'Plane Detection',
        'Detects horizontal plane.',
        Icons.blur_on,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const PlaneDetectionScreen())),
      ),
      ScreenModel(
        'Measure',
        'Measures distances',
        Icons.linear_scale,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const MeasureScreen())),
      ),
      ScreenModel(
        'Physics',
        'A sphere and a plane with dynamic and static physics',
        Icons.file_download,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const PhysicsScreen())),
      ),
      ScreenModel(
        'Occlusion',
        'Spheres which are not visible after horizontal and vertical planes.',
        Icons.blur_circular,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const OcclusionScreen())),
      ),
      ScreenModel(
        'Manipulation',
        'Custom objects with pinch and rotation events.',
        Icons.threed_rotation,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const ManipulationScreen())),
      ),
      ScreenModel(
        'Face Tracking',
        'Face mask sample.',
        Icons.face,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const FaceDetectionScreen())),
      ),
      ScreenModel(
        'Body Tracking',
        'Dash that follows your hand.',
        Icons.person,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const BodyTrackingScreen())),
      ),
      ScreenModel(
        'Panorama',
        '360 photo sample.',
        Icons.panorama,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const PanoramaScreen())),
      ),
      ScreenModel(
        'Video',
        'Video on plane',
        Icons.videocam,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => const VideoScreen())),
      ),
      ScreenModel(
        'Positioned video',
        'Positioned video on plane',
        Icons.videocam,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const PositionedVideoScreen())),
      ),
      ScreenModel(
        'Widget Projection',
        'Flutter widgets in AR',
        Icons.widgets,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const WidgetProjectionScreen())),
      ),
      ScreenModel(
        'Real Time Updates',
        'Calls a function once per frame',
        Icons.timer,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const RealTimeUpdatesScreen())),
      ),
      ScreenModel(
        'Snapshot',
        'Make a photo of AR content',
        Icons.camera,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const SnapshotSceneScreen())),
      ),
      ScreenModel(
        'Custom Object',
        'Place custom object on plane with coaching overlay.',
        Icons.nature,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const CustomObjectScreen())),
      ),
      ScreenModel(
        'Load .gltf or .glb',
        'Load .gltf or .glb from the Flutter assets or the Documents folder',
        Icons.folder_copy,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const LoadModelScreen())),
      ),
      ScreenModel(
        'Custom Animation',
        'Custom object animation. Port of https://github.com/eh3rrera/ARKitAnimation',
        Icons.accessibility_new,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const CustomAnimationScreen())),
      ),
      ScreenModel(
        'Earth',
        'Sphere with an image texture and rotation animation.',
        Icons.language,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => const EarthScreen())),
      ),
      ScreenModel(
        'Distance tracking',
        'Detects horizontal plane and track distance on it.',
        Icons.blur_on,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const DistanceTrackingScreen())),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('AR App'),
      ),
      body:
          ListView(children: samples.map((s) => ScreenCard(item: s)).toList()),
    );
  }
}
