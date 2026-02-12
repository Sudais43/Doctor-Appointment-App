import 'package:flutter/material.dart';

class AppColor extends ThemeExtension<AppColor> {
  final Color Primary;
  final Color secondary;
  final Color fontColor;
  final Color textColor;
  final Color iconColor;
  final Color tileColor;
  final Color white;
  final Color inputField;
  final Color unSelectedtextcolor;

  const AppColor({
    required this.Primary,
    required this.secondary,
    required this.fontColor,
    required this.textColor,
    required this.iconColor,
    required this.tileColor,
    required this.white,
    required this.inputField,
    required this.unSelectedtextcolor,
  });

  @override
  AppColor copyWith({
    Color? Primary,
    Color? secondary,
    Color? black,
    Color? textColor,
    Color? iconColor,
    Color? tileColor,
    Color? white,
    Color? inputField,
    Color? unSelectedtextcolor,
  }) {
    return AppColor(
      Primary: Primary ?? this.Primary,
      secondary: secondary ?? this.secondary,
      fontColor: black ?? this.fontColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      tileColor: tileColor ?? this.tileColor,
      white: white ?? this.white,
      inputField: inputField ?? this.inputField,
      unSelectedtextcolor: unSelectedtextcolor ?? this.unSelectedtextcolor,
    );
  }

  @override
  AppColor lerp(ThemeExtension<AppColor>? other, double t) {
    if (other is! AppColor) return this;

    return AppColor(
      Primary: Color.lerp(Primary, other.Primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      fontColor: Color.lerp(fontColor, other.fontColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      tileColor: Color.lerp(tileColor, other.tileColor, t)!,
      white: Color.lerp(white, other.white, t)!,
      inputField: Color.lerp(inputField, other.inputField, t)!,
      unSelectedtextcolor: Color.lerp(unSelectedtextcolor, other.unSelectedtextcolor, t)!,
    );
  }
}
