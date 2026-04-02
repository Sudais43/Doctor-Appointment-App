import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/authentication/presentation/pages/login.dart';
import 'package:skin_firts/feature/payment/presentation/pages/payment_method.dart';
import 'package:skin_firts/feature/settings/presentation/pages/edit_profile.dart';
import 'package:skin_firts/feature/settings/presentation/pages/help_center.dart';
import 'package:skin_firts/feature/settings/presentation/pages/privacy_policy.dart';
import 'package:skin_firts/feature/settings/presentation/pages/setting_page.dart';
import 'package:skin_firts/feature/settings/presentation/widgets/profile_pic.dart';
import '../../../../core/widget/CustomButton.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final appColor = context.appColors;

    return Scaffold(
      appBar: CustomAppBar(
        title: "My Profile",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(
          'current_session',
        ).listenable(keys: ['userName', 'profilePic']),
        builder: (context, sessionBox, child) {
          final userName = sessionBox.get(
            'userName',
            defaultValue: 'User Khan',
          );
          final profilePic = sessionBox.get('profilePic') as String?;
          return SingleChildScrollView(
            // Use SingleChildScrollView to prevent overflow if content is too tall
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Profile Picture with Edit Icon
                ProfilePic(networkImageUrl: profilePic),
                const SizedBox(height: 15),

                // User Name
                Text(
                  userName,
                  // 'John Doe',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: appColor.textColor,
                  ),
                ),
                const SizedBox(height: 30), // Space before the menu items
                // --- Menu Items ---
                _buildProfileMenuItem(
                  context,
                  icon: "assets/icons/settings/profile_icon.svg",
                  text: 'Profile',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfile()),
                    );
                    // Navigate to Profile screen
                  },
                ),
                
                _buildProfileMenuItem(
                  context,
                  icon: "assets/icons/settings/wallet_icon.svg",
                  text: 'Payment Method',
                  onTap: () {
                    print('Payment Method tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentMethod()),
                    );
                    // Navigate to Payment Method screen
                  },
                ),
                _buildProfileMenuItem(
                  context,
                  icon: "assets/icons/settings/privacy_icon.svg",
                  text: 'Privacy Policy',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen(),
                      ),
                    );
                    // Navigate to Privacy Policy screen
                  },
                ),
                _buildProfileMenuItem(
                  context,
                  icon: "assets/icons/settings/setting_icon.svg",
                  text: 'Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingPage()),
                    );
                    // Navigate to Settings screen
                  },
                ),
                _buildProfileMenuItem(
                  context,
                  icon: "assets/icons/settings/help_icon.svg",
                  text: 'Help',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelpCenterScreen(),
                      ),
                    );
                  },
                ),
                _buildProfileMenuItem(
                  context,
                  icon: "assets/icons/settings/log_out_icon.svg",
                  text: 'Logout',
                  onTap: () {
                    print('Logout tapped');
                    _showLogoutDialog(context, appColor);
                    // Implement logout logic
                  },
                  isLogout: true, // Special styling for Logout
                ),
                const SizedBox(height: 70), // Bottom padding
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper method to build each menu item ListTile
  Widget _buildProfileMenuItem(
    BuildContext context, {
    required String icon,
    required String text,
    required VoidCallback onTap,
    bool isLogout = false, // To apply specific styling for logout
  }) {
    final appColor = context.appColors;
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 22, // Size of the icon background circle
            backgroundColor: appColor.Primary.withOpacity(
              0.1,
            ), // Light blue background
            child: SvgPicture.asset(icon, color: appColor.Primary),
          ),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: appColor.fontColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing:
              isLogout
                  ? null
                  : const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.grey, // Grey arrow for other items
                  ),
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 5.0,
          ),
        ),
      ],
    );
  }

  // --- 7. HELPER FUNCTION FOR THE LOGOUT DIALOG ---
  void _showLogoutDialog(BuildContext context, AppColor appColor) {
    // showModalBottomSheet is the widget that slides up from the bottom
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Make sheet transparent
      builder: (context) {
        // Use a Container to create the rounded white box
        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Make column wrap content
            children: [
              // --- Dialog Content ---
              Text(
                "Logout",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: appColor.Primary,
                  fontFamily: "LeagueSpartan",
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "are you sure you want to log out?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontFamily: "LeagueSpartan",
                ),
              ),
              const SizedBox(height: 25),

              // --- Dialog Buttons ---
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Cancel",
                      BackgroundColor: appColor.secondary,
                      textStyle: TextStyle(
                        color: appColor.Primary,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomButton(
                      text: "Yes, Logout",
                      BackgroundColor: appColor.Primary,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () async {
                        // Clear the current session from Hive
                        final sessionBox = Hive.box('current_session');
                        await sessionBox.clear();

                        if (!context.mounted) return;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LogIn()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
