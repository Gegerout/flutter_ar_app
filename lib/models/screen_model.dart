import 'package:flutter/cupertino.dart';

class ScreenModel {
  const ScreenModel(this.title, this.description, this.icon, this.onTap);

  final String title;
  final String description;
  final IconData icon;
  final Function onTap;
}
