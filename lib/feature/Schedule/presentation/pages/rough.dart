import 'package:flutter/material.dart';

// 1. Reusable Circular Button Widget (Optimized for reuse)
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
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}

// 2. The Custom AppBar Widget
class CustomDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Define colors locally or use your theme
    const Color primaryBlue = Color(0xFF2962FF);
    const Color lightBlueBg = Color(0xFFE0E7FF); // Light blue for right buttons

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false, // Important: Aligns title row to the left
      titleSpacing: 0, // Reduces gap between back button and title

      // --- Leading (Back Button) ---
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: primaryBlue),
        onPressed: () => Navigator.pop(context),
      ),

      // --- Title (Center Actions) ---
      title: SingleChildScrollView( // Prevents overflow on small screens
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // 1. Schedule Pill Button
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.calendar_month_outlined, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    "Schedule",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // 2. Communication Buttons (Blue Background)
            CircularAppBarButton(
              icon: Icons.call_outlined,
              backgroundColor: primaryBlue,
              iconColor: Colors.white,
              onTap: () {},
            ),
            const SizedBox(width: 10),
            CircularAppBarButton(
              icon: Icons.videocam_outlined,
              backgroundColor: primaryBlue,
              iconColor: Colors.white,
              onTap: () {},
            ),
            const SizedBox(width: 10),
            CircularAppBarButton(
              icon: Icons.chat_bubble_outline,
              backgroundColor: primaryBlue,
              iconColor: Colors.white,
              onTap: () {},
            ),
          ],
        ),
      ),

      // --- Actions (Right Side Buttons) ---
      actions: [
        Row(
          children: [
            // Light Blue Buttons
            CircularAppBarButton(
              icon: Icons.help_outline,
              backgroundColor: lightBlueBg,
              iconColor: primaryBlue,
              onTap: () {},
            ),
            const SizedBox(width: 10),
            CircularAppBarButton(
              icon: Icons.favorite,
              backgroundColor: lightBlueBg,
              iconColor: primaryBlue,
              onTap: () {},
            ),
            const SizedBox(width: 16), // End padding
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// --- Usage Example ---
class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomDetailAppBar(),
      body: Center(child: Text("Page Content")),
    );
  }
}