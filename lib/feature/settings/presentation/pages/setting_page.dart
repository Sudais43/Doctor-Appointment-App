import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/settings/presentation/pages/notification_Setting.dart';
import 'package:skin_firts/feature/settings/presentation/pages/password_manager.dart';

import '../../../../core/color/light/LIghtColorPalette.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings", onPressed: (){}),
      body: SafeArea(
          child: Column(
            children: [
              _buildProfileMenuItem(
                context,
                icon: "assets/icons/settings/notification_setting_icon.svg",
                text: 'Notification Setting',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationSettingsScreen()),
                  );
                },
              ),
              _buildProfileMenuItem(
                context,
                icon: "assets/icons/settings/password_icon.svg",
                text: 'Password Manager',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordManager()),
                  );

                },
              ),
              _buildProfileMenuItem(
                context,
                icon: "assets/icons/settings/profile_icon.svg",
                text: 'Delete Account',
                onTap: () {
                },
              ),
            ],
          ),
      ),
    );
  }

  Widget _buildProfileMenuItem(
      BuildContext context, {
        required String icon,
        required String text,
        required VoidCallback onTap,
        bool isLogout = false, // To apply specific styling for logout
      }) {
    return Column(
      children: [
        ListTile(
          leading: SvgPicture.asset(
            icon,
            color: isLogout ? Colors.red : LightColorPalette.iconColor, // Red for logout, primary for others
          ),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: isLogout ? Colors.red : LightColorPalette.textColor, // Red for logout, normal for others
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: isLogout ? null : const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey, // Grey arrow for other items
          ),
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
        ),
        // You can add a Divider here if you want lines between items
        // if (!isLogout)
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
        //     child: Divider(color: LightColorPalette.dividerColor.withOpacity(0.3), height: 1),
        //   ),
      ],
    );
  }
}
