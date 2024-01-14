import 'dart:io';

import 'package:flutter/services.dart';

enum IconType { normal, yellow, red, newRed }

class AppIcon {
  static const MethodChannel platform = MethodChannel('appIconChannel');

  static Future<void> setLauncherIcon(IconType icon) async {
    if (!Platform.isIOS) return;

    String iconName;

    switch (icon) {
      case IconType.yellow:
        iconName = 'Yellow';
        break;
      case IconType.red:
        iconName = 'Red';
        break;
      case IconType.newRed:
        iconName = 'NewRed';
        break;
      default:
        iconName = 'Normal';
        break;
    }

    return await platform.invokeMethod('changeIcon', iconName);
  }
}