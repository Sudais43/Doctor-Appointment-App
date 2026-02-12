import 'dart:ui';

import 'package:skin_firts/core/theme/app_color.dart';

class LightColorPalette {
  static const Color primary = Color(0xFF2260FF);
  static const Color secondary = Color(0xFFCAD6FF);
  static const Color black = Color(0xFF000000);
  static const Color textColor = Color(0xFF809CFF);
  static const Color iconColor = Color(0xFF00278C);
  static const Color tileColor = Color(0xFFECF1FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color inputField = Color(0xFFECF1FF);
  static const Color unSelectedtextcolor = Color(0xFFA9BCFE);

  static const light = AppColor(
    Primary: Color(0xFF2260FF),
    secondary: Color(0xFFCAD6FF),
    fontColor: Color(0xFF000000),
    textColor: Color(0xFF809CFF),
    iconColor: Color(0xFF00278C),
    tileColor: Color(0xFFECF1FF),
    white: Color(0xFFFFFFFF),
    inputField: Color(0xFFECF1FF),
    unSelectedtextcolor: Color(0xFFA9BCFE),
  );

  static const dark = AppColor(
    Primary: Color(0xFF3871FF),
    secondary: Color(0xFF1E293B),
    fontColor: Color(0xFFFFFFFF),
    textColor: Color(0xFF94A3B8),
    iconColor: Color(0xFF60A5FA),
    tileColor: Color(0xFF1E293B),
    white: Color(0xFFF8FAFC),
    inputField: Color(0xFF334155),
    unSelectedtextcolor: Color(0xFF475569),
  );
}
