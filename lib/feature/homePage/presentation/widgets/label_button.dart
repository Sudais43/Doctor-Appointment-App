import 'package:flutter/material.dart';

import '../../../../core/color/light/LIghtColorPalette.dart';

class LabelButton extends StatelessWidget {

  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final double spacing;
  final TextStyle? textStyle;

  const LabelButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.spacing = 6.0,
    this.color = LightColorPalette.primary,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          IconTheme(
              data: IconThemeData(color: color, size: 15),
              child: icon
          ),
          SizedBox(height: spacing,),

          Text(
            label,
            style: textStyle ?? TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
