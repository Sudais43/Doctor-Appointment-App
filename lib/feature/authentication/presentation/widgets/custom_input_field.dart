import 'package:flutter/material.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final double? height;
  final double? width;
  final Widget? suffixIcon; // ✅ Changed to widget for flexibility

  const CustomInputField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.height = 45,
    this.width = 299,
    this.suffixIcon, // ✅ Optional (only shown if passed)
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: LightColorPalette.secondary,
          hintText: label,
          hintStyle: const TextStyle(
            fontFamily: "LeagueSpartan",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: LightColorPalette.textColor,
          ),
          suffixIcon: suffixIcon, // ✅ only shows if provided
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14, // ✅ centers hint text vertically
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
