import 'package:flutter/material.dart';

import '../color/light/LIghtColorPalette.dart';

class CustomButton extends StatelessWidget {

  final double width;
  final double height;
  final String text;
  final VoidCallback onPressed;
  final Color BackgroundColor;
  final BorderRadiusGeometry borderRadius;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    this.height = 45,
    this.width = 207,
    required this.text,
    required this.onPressed,
    this.BackgroundColor = LightColorPalette.primary,
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: BackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
          onPressed: onPressed,
          child: Text(
              text,
              style: textStyle ?? const TextStyle(
                color: LightColorPalette.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )
          )
      ),
    );
  }
}
