import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart'; // Adjust path

class CircularIconButton extends StatelessWidget {
   // For Material Icons
  final String? svgAsset; // For SVG assets
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  const CircularIconButton({
    super.key,
    this.svgAsset,
    required this.onPressed,
    this.backgroundColor = LightColorPalette.primary, // Default to primary blue
    this.iconColor = Colors.white, // Default to white icon
    this.size = 40.0, // Diameter of the circle
    this.iconSize = 24.0, // Size of the icon itself
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: 24,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child:SvgPicture.asset(
            svgAsset!,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            width: iconSize,
            height: iconSize,
          ),
        ),
      ),
    );
  }
}