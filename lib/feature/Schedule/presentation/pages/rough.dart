import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';

// 1. Reusable Circular Button Widget
class CircularAppBarButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;

  const CircularAppBarButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30, // Shrunk slightly to ensure fit on all screens
        height: 30,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 16),
      ),
    );
  }
}

// 2. The Custom AppBar Widget
class CustomDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String doctorName;
  const CustomDetailAppBar({super.key, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    Color primaryBlue = appColor.Primary;
    Color lightBlueBg = appColor.Primary.withOpacity(0.2);

    return AppBar(
      backgroundColor: appColor.white,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0, // Keeps the name close to the back button
      // --- Leading (Back Button) ---
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: primaryBlue),
        onPressed: () => Navigator.pop(context),
      ),

      // --- Title (Name Pill Only) ---
      title: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          doctorName,
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis, // Prevents overflow if name is very long
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13, // Slightly smaller to ensure fit
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // --- Actions (All 5 Icons grouped on the right) ---
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dark Blue Buttons
              CircularAppBarButton(
                icon: Icons.phone_in_talk_outlined,
                backgroundColor: primaryBlue,
                iconColor: Colors.white,
                onTap: () {},
              ),
              const SizedBox(width: 4),
              CircularAppBarButton(
                icon: Icons.videocam_outlined,
                backgroundColor: primaryBlue,
                iconColor: Colors.white,
                onTap: () {},
              ),
              const SizedBox(width: 4),
              CircularAppBarButton(
                icon: Icons.chat_bubble_outline,
                backgroundColor: primaryBlue,
                iconColor: Colors.white,
                onTap: () {},
              ),
              const SizedBox(width: 4),

              // Light Blue Buttons
              CircularAppBarButton(
                icon: Icons.question_mark_rounded,
                backgroundColor: lightBlueBg,
                iconColor: primaryBlue,
                onTap: () {},
              ),
              const SizedBox(width: 4),
              CircularAppBarButton(
                icon: Icons.favorite,
                backgroundColor: lightBlueBg,
                iconColor: primaryBlue,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
