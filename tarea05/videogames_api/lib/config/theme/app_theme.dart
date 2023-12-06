import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getAppTheme() => ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.green,
    useMaterial3: true,
  );
}