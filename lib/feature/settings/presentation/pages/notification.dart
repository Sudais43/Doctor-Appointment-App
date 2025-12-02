import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/color/light/LIghtColorPalette.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                const Text('News', style: TextStyle(color: Colors.blue)),
                const SizedBox(width: 4),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDateSeparator('Today'),
          const SizedBox(height: 16),
          _buildNotificationItem(
            iconPath: 'assets/icons/BottomNaveBar/calender_icon.svg',
            title: 'Scheduled Appointment',
            time: '2M',
            isRead: true,
          ),
          _buildNotificationItem(
            iconPath: 'assets/icons/BottomNaveBar/calender_icon.svg',
            title: 'Scheduled Change',
            time: '2H',
            isRead: true,
          ),
          _buildNotificationItem(
            iconPath: 'assets/icons/BottomNaveBar/calender_icon.svg', // Placeholder
            title: 'Medical Notes',
            time: '3H',
            isRead: false,
          ),
          const SizedBox(height: 16),
          _buildDateSeparator('Yesterday'),
          const SizedBox(height: 16),
          _buildNotificationItem(
            iconPath: 'assets/icons/BottomNaveBar/calender_icon.svg',
            title: 'Scheduled Appointment',
            time: '1D',
            isRead: false,
          ),
          const SizedBox(height: 16),
          _buildDateSeparator('15 April'),
          const SizedBox(height: 16),
          _buildNotificationItem(
            iconPath: 'assets/icons/BottomNaveBar/calender_icon.svg',
            title: 'Medical History Update',
            time: '5D',
            isRead: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDateSeparator(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(text, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
        if (text == 'Today')
          TextButton(
            onPressed: () {},
            child: const Text('Mark all', style: TextStyle(color: Colors.blue)),
          ),
      ],
    );
  }

  Widget _buildNotificationItem({
    required String iconPath,
    required String title,
    required String time,
    required bool isRead,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: isRead ? LightColorPalette.secondary : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: LightColorPalette.primary,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              iconPath,
              color: Colors.white,
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}
