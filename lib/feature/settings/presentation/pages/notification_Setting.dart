import 'package:flutter/material.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';

import '../../data/notification_setting_data.dart';
import '../../domain/entity/notification_setting.dart';


class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({
    super.key
  });

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Notification Setting", onPressed: (){}),
      // --- 3. Use ListView.builder for efficient list rendering ---
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 16.0),
        itemCount: settings.length,
        itemBuilder: (context, index) {
          // Get the specific setting for this row
          final setting = settings[index];
          // Build the row using our reusable helper function
          return _buildSettingRow(setting);
        },
      ),
    );
  }

  Widget _buildSettingRow(NotificationSetting setting) {
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
              color: Colors.black.withOpacity(0.85),
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
            activeColor: LightColorPalette.primary,
            inactiveTrackColor: LightColorPalette.secondary.withOpacity(0.4),
            inactiveThumbColor: LightColorPalette.white,
            trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }
}