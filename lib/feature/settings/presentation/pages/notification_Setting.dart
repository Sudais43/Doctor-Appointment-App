import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:skin_firts/core/services/api_services.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
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
  late Box _settingsBox;
  bool _isLoading = true;

  final ApiServices apiServices = ApiServices();

  Future<void> _initHiveAndLoadSettings() async {
    // Open the box (ensure you've initialized Hive in main.dart!)
    _settingsBox = await Hive.openBox('settings_box');

    setState(() {
      // Loop through your hardcoded 'settings' list and update their 'value'
      // based on what is saved in Hive. If nothing is saved, use the default.
      for (var setting in settings) {
        // The title (e.g., "Sound") is the key.
        // We remove spaces so "App Update" becomes "AppUpdate" to match the Node.js schema
        String dbKey = setting.title.replaceAll(' ', '');

        setting.value = _settingsBox.get(dbKey, defaultValue: setting.value);
      }
      _isLoading = false;
    });
  }

  Future<void> _toggleSetting(
    NotificationSetting setting,
    bool newValue,
  ) async {
    // 1. Instantly update the UI so it feels fast
    setState(() {
      setting.value = newValue;
    });

    String dbKey = setting.title.replaceAll(' ', '');

    // 2. Save locally to Hive so it remembers on next app launch
    await _settingsBox.put(dbKey, newValue);

    // 3. Sync to your Node.js backend in the background
    final response = await apiServices.updateNotificationSetting(
      dbKey,
      newValue,
    );

    if (response == null || response.statusCode != 200) {
      // If the server failed, you could optionally revert the toggle here
      debugPrint("Failed to sync setting to server: $dbKey");
    }
  }

  @override
  void initState() {
    super.initState();
    _initHiveAndLoadSettings();
  }

  @override
  Widget build(BuildContext context) {
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
      body: _isLoading
      ? const Center(child: CircularProgressIndicator()) 
      :Column(
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
            ),
          ),

          // The toggle switch
          Switch(
            value: setting.value,
            onChanged: (newValue) {
              _toggleSetting(setting, newValue);
              // You could also add a function here to save the setting
              // e.g., _saveSetting(setting.title, newValue);
            },
            // Style the switch to match your image
            activeThumbColor: appColor.Primary,
            inactiveTrackColor: appColor.secondary,
            inactiveThumbColor: appColor.white,
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }
}
