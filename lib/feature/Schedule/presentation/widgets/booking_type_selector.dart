import 'package:flutter/material.dart';

// If you have your palette file, import it.
// Otherwise, I will use constants here for the demo.
// import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';

class BookingTypeSelector extends StatefulWidget {
  final Function(String) onSelectionChanged;

  const BookingTypeSelector({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  State<BookingTypeSelector> createState() => _BookingTypeSelectorState();
}

class _BookingTypeSelectorState extends State<BookingTypeSelector> {
  // 'Yourself' is selected by default. Change to "" if you want neither selected initially.
  String _selectedOption = "Yourself";

  // Colors extracted from your image
  final Color _activeColor = const Color(0xFF2962FF); // Bright Blue
  final Color _inactiveBorderColor = const Color(0xFFA0B5FF); // Light Blue Border
  final Color _inactiveTextColor = const Color(0xFF8FA1D0); // Muted Blue Text

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Option 1: Yourself
        _buildOptionBtn(
          text: "Yourself",
          isSelected: _selectedOption == "Yourself",
          onTap: () => _handleSelection("Yourself"),
        ),

        const SizedBox(width: 15), // Gap between buttons

        // Option 2: Another Person
        _buildOptionBtn(
          text: "Another Person",
          isSelected: _selectedOption == "Another Person",
          onTap: () => _handleSelection("Another Person"),
        ),
      ],
    );
  }

  void _handleSelection(String option) {
    setState(() {
      _selectedOption = option;
    });
    // Send value back to parent
    widget.onSelectionChanged(option);
  }

  // --- Reusable Button Widget ---
  Widget _buildOptionBtn({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        decoration: BoxDecoration(
          // If selected: Blue background. If not: White background.
          color: isSelected ? _activeColor : Colors.white,
          borderRadius: BorderRadius.circular(30), // Capsule shape
          border: isSelected
              ? null // No border when filled
              : Border.all(color: _inactiveBorderColor, width: 2),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              fontFamily: "LeagueSpartan",
              // If selected: White text. If not: Blue text.
              color: isSelected ? Colors.white : _inactiveBorderColor,
            ),
          ),
        ),
      ),
    );
  }
}