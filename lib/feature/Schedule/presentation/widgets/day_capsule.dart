import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/color/light/LIghtColorPalette.dart';

class DayCapsule extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isAvailable; // Added this parameter
  final VoidCallback onTap;

  const DayCapsule({
    super.key,
    required this.date,
    required this.isSelected,
    required this.isAvailable, // Added this
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine Background Color
    Color bgColor;
    if (isSelected) {
      bgColor = LightColorPalette.primary;
    } else if (isAvailable) {
      bgColor = Colors.white;
    } else {
      bgColor = LightColorPalette.white; // Disabled color
    }

    // Determine Text Color
    Color textColor;
    if (isSelected) {
      textColor = Colors.white;
    } else if (isAvailable) {
      textColor = LightColorPalette.primary;
    } else {
      textColor = LightColorPalette.secondary; // Disabled text color
    }

    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Opacity(
        opacity: isAvailable ? 1.0 : 0.6, // Visual cue for disabled
        child: Container(
          width: 60,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: LightColorPalette.primary.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ]
                : null,
            border: isAvailable && !isSelected
                ? Border.all(color: Colors.grey.shade100) // Optional border for white items
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date.day.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: "LeagueSpartan",
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('E').format(date).toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "LeagueSpartan",
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}