import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearchChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 300, // Keep width flexible or defined based on parent needs
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: Colors.white, // Using Colors.white for the background
        boxShadow: [
          // Optional: Add a subtle shadow for better depth
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        // CRUCIAL: Captures input changes and passes them up
        onChanged: onSearchChanged,

        // 2. Styling the TextField
        style: const TextStyle(fontSize: 14.0, color: Colors.black),
        textAlignVertical: TextAlignVertical.center, // Vertically center the text

        // 3. Adding the Hint and Icon via InputDecoration
        decoration: InputDecoration(
          hintText: "Search...", // ⬅️ The Hint Text
          hintStyle: TextStyle(color: Colors.grey[400]),

          // Use Icon for the leading search symbol
          prefixIcon: SvgPicture.asset("assets/icons/HomeScreen/search_icon.svg", fit: BoxFit.scaleDown,),

          // Remove all default borders
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          // Ensure padding is minimized so text field fits well in 33 height
          contentPadding: const EdgeInsets.only(bottom: 12),
        ),
      ),
    );
  }
}