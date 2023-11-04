import 'package:ar_app/screens/panorama_page.dart';
import 'package:ar_app/screens/physics_screen.dart';
import 'package:ar_app/screens/plane_detection_screen.dart';
import 'package:ar_app/screens/positioned_video_screen.dart';
import 'package:ar_app/screens/real_time_updates_screen.dart';
import 'package:ar_app/screens/snapshot_scene_screen.dart';
import 'package:ar_app/screens/tap_screen.dart';
import 'package:ar_app/screens/video_screen.dart';
import 'package:ar_app/screens/widget_projection_screen.dart';
import 'package:flutter/material.dart';

import 'body_tracking_screen.dart';
import 'custom_animation_screen.dart';
import 'custom_object_screen.dart';
import 'distance_tracking_screen.dart';
import 'face_detection_screen.dart';
import 'manipulation_screen.dart';
import 'measure_screen.dart';
import 'occlusion_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final samples = [
      Sample(
        'Tap',
        'Sphere which handles tap event.',
        Icons.touch_app,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => const TapPage())),
      ),
      Sample(
        'Plane Detection',
        'Detects horizontal plane.',
        Icons.blur_on,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const PlaneDetectionPage())),
      ),
      Sample(
        'Measure',
        'Measures distances',
        Icons.linear_scale,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => const MeasurePage())),
      ),
      Sample(
        'Physics',
        'A sphere and a plane with dynamic and static physics',
        Icons.file_download,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => const PhysicsPage())),
      ),
      Sample(
        'Occlusion',
        'Spheres which are not visible after horizontal and vertical planes.',
        Icons.blur_circular,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const OcclusionPage())),
      ),
      Sample(
        'Manipulation',
        'Custom objects with pinch and rotation events.',
        Icons.threed_rotation,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const ManipulationPage())),
      ),
      Sample(
        'Face Tracking',
        'Face mask sample.',
        Icons.face,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const FaceDetectionPage())),
      ),
      Sample(
        'Body Tracking',
        'Dash that follows your hand.',
        Icons.person,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const BodyTrackingPage())),
      ),
      Sample(
        'Panorama',
        '360 photo sample.',
        Icons.panorama,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const PanoramaPage())),
      ),
      Sample(
        'Video',
        'Video on plane',
        Icons.videocam,
        () => Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (c) => const VideoPage())),
      ),
      Sample(
        'Positioned video',
        'Positioned video on plane',
        Icons.videocam,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const PositionedVideoPage())),
      ),
      Sample(
        'Widget Projection',
        'Flutter widgets in AR',
        Icons.widgets,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const WidgetProjectionPage())),
      ),
      Sample(
        'Real Time Updates',
        'Calls a function once per frame',
        Icons.timer,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const RealTimeUpdatesPage())),
      ),
      Sample(
        'Snapshot',
        'Make a photo of AR content',
        Icons.camera,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const SnapshotScenePage())),
      ),
      Sample(
        'Custom Object',
        'Place custom object on plane with coaching overlay.',
        Icons.nature,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const CustomObjectPage())),
      ),
      Sample(
        'Custom Animation',
        'Custom object animation. Port of https://github.com/eh3rrera/ARKitAnimation',
        Icons.accessibility_new,
        () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const CustomAnimationPage())),
      ),
      Sample(
        'Distance tracking',
        'Detects horizontal plane and track distance on it.',
        Icons.blur_on,
            () => Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (c) => const DistanceTrackingPage())),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('AR App'),
      ),
      body:
          ListView(children: samples.map((s) => SampleItem(item: s)).toList()),
    );
  }
}

class SampleItem extends StatelessWidget {
  const SampleItem({
    required this.item,
    Key? key,
  }) : super(key: key);
  final Sample item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => item.onTap(),
        child: ListTile(
          leading: Icon(item.icon),
          title: Text(
            item.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            item.description,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}

class Sample {
  const Sample(this.title, this.description, this.icon, this.onTap);

  final String title;
  final String description;
  final IconData icon;
  final Function onTap;
}
