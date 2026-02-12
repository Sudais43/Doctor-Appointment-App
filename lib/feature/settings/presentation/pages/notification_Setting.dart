import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/core/theme/theme_provider.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';

import '../../data/notification_setting_data.dart';
import '../../domain/entity/notification_setting.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final appColor = context.appColors;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(),
        title: Text(
          "Notification Setting",
          style: TextStyle(
            color: appColor.Primary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 16.0),
              itemCount: settings.length,
              itemBuilder: (context, index) {
                // Get the specific setting for this row
                final setting = settings[index];
                // Build the row using our reusable helper function
                return _buildSettingRow(setting, appColor, context);
              },
            ),
          ),

          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeProvider.isDark,
            onChanged: (_) => themeProvider.toggle(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow(
    NotificationSetting setting,
    AppColor appColor,
    BuildContext context,
  ) {
    return Padding(
      // Padding matches the spacing in your image
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // The title text
          Text(
            setting.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // color: appColor?.black,
            ),
          ),

          // The toggle switch
          Switch(
            value: setting.value,
            onChanged: (newValue) {
              // When tapped, update the state for this specific setting
              setState(() {
                setting.value = newValue;
              });
              // You could also add a function here to save the setting
              // e.g., _saveSetting(setting.title, newValue);
            },
            // Style the switch to match your image
            activeColor: appColor.Primary,
            inactiveTrackColor: appColor.secondary,
            inactiveThumbColor: appColor.white,
            trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }
}
