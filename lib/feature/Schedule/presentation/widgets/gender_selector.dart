import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';

// If you have your palette file, import it.
// Otherwise, I will use constants here for the demo.
// import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';

class GenderSelector extends StatefulWidget {
  final Function(String) onSelectionChanged;

  const GenderSelector({super.key, required this.onSelectionChanged});

  @override
  State<GenderSelector> createState() => _BookingTypeSelectorState();
}

class _BookingTypeSelectorState extends State<GenderSelector> {
  // 'Yourself' is selected by default. Change to "" if you want neither selected initially.
  String _selectedOption = "Yourself";


  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    return Row(
      children: [
        // Option 1: Yourself
        _buildOptionBtn(
          text: "Male",
          isSelected: _selectedOption == "Male",
          onTap: () => _handleSelection("Male"),
          appColor: appColor,
        ),

        const SizedBox(width: 15), // Gap between buttons
        // Option 2: Another Person
        _buildOptionBtn(
          text: "Female",
          isSelected: _selectedOption == "Female",
          onTap: () => _handleSelection("Female"),
          appColor: appColor,
        ),

        _buildOptionBtn(
          text: "Other",
          isSelected: _selectedOption == "Other",
          onTap: () => _handleSelection("Other"),
          appColor: appColor,
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
    required AppColor appColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        decoration: BoxDecoration(
          // If selected: Blue background. If not: White background.
          color: isSelected ? appColor.Primary : appColor.white,
          borderRadius: BorderRadius.circular(30), // Capsule shape
          border:
              isSelected
                  ? null // No border when filled
                  : Border.all(color: appColor.secondary, width: 2),
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
              color: isSelected ? appColor.white : appColor.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
