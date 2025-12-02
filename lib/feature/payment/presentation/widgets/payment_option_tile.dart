import 'package:flutter/material.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';

class PaymentOptionTile extends StatelessWidget {
  final IconData icon; // Change to String if using SVG assets
  final String title;
  final int value;
  final int groupValue;
  final Color primaryColor;
  final Function(int) onTap;

  const PaymentOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: LightColorPalette.inputField,
          borderRadius: BorderRadius.circular(30), // Capsule shape
        ),
        child: Row(
          children: [
            // The Icon
            // If using SVGs: SvgPicture.asset(icon, color: primaryColor)
            Icon(
              icon,
              color: primaryColor,
              size: 28,
            ),

            const SizedBox(width: 15),

            // The Text
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: primaryColor.withOpacity(0.7), // Slightly lighter text
                fontWeight: FontWeight.w500,
                fontFamily: "LeagueSpartan",
              ),
            ),

            const Spacer(),

            // Custom Radio Button
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
                color: Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}