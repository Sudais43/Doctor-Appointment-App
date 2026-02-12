import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/theme/color_palette.dart'; // Adjust path
import 'circular_icon_button.dart'; // Import the helper widget

class DoctorProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackButtonPressed;
  final VoidCallback onSchedulePressed;
  final VoidCallback onCallPressed;
  final VoidCallback onVideoCallPressed;
  final VoidCallback onChatPressed;
  final VoidCallback onHelpPressed;
  final VoidCallback onFavoritePressed;

  const DoctorProfileAppbar({
    super.key,
    required this.onBackButtonPressed,
    required this.onSchedulePressed,
    required this.onCallPressed,
    required this.onVideoCallPressed,
    required this.onChatPressed,
    required this.onHelpPressed,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: AppBar(
        backgroundColor: Colors.white, // White background for the entire app bar
        elevation: 0, // No shadow
        titleSpacing: 0,
        leadingWidth: 35, // Adjust leading space for the back button
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: LightColorPalette.primary, // Blue back arrow
            size: 24,
          ),
          onPressed: onBackButtonPressed,
        ),
        title: Row(
          children: [
            // Schedule Button (Pill Shape)
            GestureDetector(
              onTap: onSchedulePressed,
              child: Container(
                height: 21,
                width: 100,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: LightColorPalette.primary, // Blue pill
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Doctors/calender_icon.svg", // Your calendar SVG
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "Schedule",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        fontFamily: "LeagueSpartan",
                      ),
                    ),
                  ],
                ),
              ),
            ), // Spacing between pill and circular icons
            // Call Icon
            CircularIconButton(
              svgAsset: "assets/icons/Doctors/voice_call_icon.svg",
              // icon: Icons.phone,
              onPressed: onCallPressed,
            ),

            // Video Call Icon
            CircularIconButton(
              svgAsset: "assets/icons/Doctors/video_call_icon.svg",
              onPressed: onVideoCallPressed,
            ),

            // Chat Icon
            CircularIconButton(
              svgAsset: "assets/icons/Doctors/chatting_icon.svg",
              onPressed: onChatPressed,
              size: 38,
              iconSize: 20,
            ),
          ],
        ),
        actions: [
          // Help Icon (Light Blue)
          CircularIconButton(
            svgAsset: "assets/icons/Doctors/question_mark_icon.svg",
            onPressed: onHelpPressed,
            backgroundColor: LightColorPalette.secondary.withOpacity(0.5), // Light blue background
            iconColor: LightColorPalette.primary, // Darker blue icon
            size: 38,
            iconSize: 20,
          ),

          // Favorite Icon (Light Blue)
          CircularIconButton(
            svgAsset: "assets/icons/Doctors/favorite_outline_icon.svg",
            onPressed: onFavoritePressed,
            backgroundColor: LightColorPalette.secondary.withOpacity(0.5),
            iconColor: LightColorPalette.primary,

          ),
          const SizedBox(width: 16), // Padding at the end
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard app bar height
}