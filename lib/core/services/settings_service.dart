import 'package:flutter/material.dart';

class SettingsService {
  int scoreCap = 25;

  Color team1Color = Colors.red;
  Color team2Color = Colors.blue;

  List<Color> availableColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.black
  ];

  bool isLandscapeMode = true;
}
