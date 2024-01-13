import 'package:flutter/material.dart';

import '../utils/app_icon.dart';

class ChangeIconScreen extends StatelessWidget {
  const ChangeIconScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Launcher Icon'),
      ),
      body: const Center(
        child: Row(
          children: <Widget>[
            IconSelector(
              appIcon: IconType.Standart,
              imageAsset: 'assets/icon/icon.png',
              name: 'Normal',
            ),
            IconSelector(
              appIcon: IconType.Yellow,
              imageAsset: 'assets/icon/icon_yellow.png',
              name: 'Yellow',
            ),
            IconSelector(
              appIcon: IconType.Red,
              imageAsset: 'assets/icon/icon_red.png',
              name: 'Red',
            ),
            IconSelector(
              appIcon: IconType.NewRed,
              imageAsset: 'assets/icon/icon_new_red.png',
              name: 'NewRed',
            ),
          ],
        ),
      ),
    );
  }
}

class IconSelector extends StatelessWidget {
  final IconType appIcon;
  final String imageAsset;
  final String name;

  const IconSelector(
      {super.key,
      required this.appIcon,
      required this.imageAsset,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(imageAsset),
              Text(name),
            ],
          ),
        ),
        onTap: () {
          AppIcon.setLauncherIcon(appIcon);
        },
      ),
    );
  }
}
