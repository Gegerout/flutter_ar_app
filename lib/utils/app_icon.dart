import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

enum IconType { Standart, Yellow, Red, NewRed }

class AppIcon {
  static const MethodChannel platform = MethodChannel('appIconChannel');

  static Future<void> setLauncherIcon(IconType icon) async {
    if (!Platform.isIOS) return;

    String iconName;

    switch (icon) {
      case IconType.Yellow:
        iconName = 'Yellow';
        break;
      case IconType.Red:
        iconName = 'Red';
        break;
      case IconType.NewRed:
        iconName = 'NewRed';
        break;
      default:
        iconName = 'Normal';
        break;
    }

    return await FlutterDynamicIcon.setAlternateIconName(iconName);
  }
}