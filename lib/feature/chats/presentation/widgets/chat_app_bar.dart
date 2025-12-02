import 'package:flutter/material.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart'; // Ensure correct path

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onPressed; // For the back button
  final List<Widget>? actions; // Added for actions

  const ChatAppBar({
    super.key,
    required this.title,
    required this.onPressed,
    this.actions, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: LightColorPalette.primary, // Blue background
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: onPressed,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: "LeagueSpartan",
        ),
      ),
      actions: actions, // Pass actions here
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}