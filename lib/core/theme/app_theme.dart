import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/color_palette.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: LightColorPalette.white,
    extensions: const [LightColorPalette.light],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: LightColorPalette.black,
    extensions: const [LightColorPalette.dark],
  );
}
