import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/color_palette.dart';

class CustomSnackBar {
  /// Shows a beautifully designed, floating SnackBar.
  /// Pass [isError: true] for a red background and error icon.
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "LeagueSpartan",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: isError ? Colors.redAccent : LightColorPalette.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      elevation: 6,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
