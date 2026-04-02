import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/feature/homePage/domain/entities/app_notification.dart';
import 'package:skin_firts/feature/homePage/presentation/view_model/home_page_view_model.dart';
import 'package:skin_firts/feature/settings/presentation/widgets/notification_tile_widget.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // ... (Keep your exact same AppBar code here) ...
      ),
      // 👇 Update the body to listen to the ViewModel
      body: Consumer<HomePageViewModel>(
        builder: (context, viewModel, child) {
          final notifications = viewModel.notifications;

          if (notifications.isEmpty) {
            return const Center(child: Text("No new notifications"));
          }

          // 1. Group the notifications by date
          final Map<String, List<AppNotification>> groupedNotifications = {};
          
          for (var notif in notifications) {
            String header = _getDateHeader(notif.timestamp);
            if (!groupedNotifications.containsKey(header)) {
              groupedNotifications[header] = [];
            }
            groupedNotifications[header]!.add(notif);
          }

          // 2. Build the UI list from the grouped data
          List<Widget> listItems = [];
          
          groupedNotifications.forEach((header, notifList) {
            // Add the Date Separator (Today, Yesterday, etc.)
            listItems.add(_buildDateSeparator(header, viewModel));
            listItems.add(const SizedBox(height: 16));

            // Add the actual notification items for that date
            for (var notif in notifList) {
              listItems.add(NotificationTile( // 👈 Use the new widget!
                iconPath: 'assets/icons/BottomNaveBar/calender_icon.svg', 
                title: notif.title,
                body: notif.body, 
                time: _formatTimeDifference(notif.timestamp), 
                isRead: notif.isRead, 
              ));
            }
            listItems.add(const SizedBox(height: 16));
          });

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: listItems,
          );
        },
      ),
    );
  }

  // --- UPDATED DATE SEPARATOR ---
  Widget _buildDateSeparator(String text, HomePageViewModel viewModel) {
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
            onPressed: () {
              // Add a markAllAsRead method to your ViewModel if you want this to work!
              // viewModel.markAllAsRead(); 
            },
            child: const Text('Mark all', style: TextStyle(color: Colors.blue)),
          ),
      ],
    );
  }


  // Calculates if a date is Today, Yesterday, or a specific date like "15 April"
  String _getDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final notifDate = DateTime(date.year, date.month, date.day);

    if (notifDate == today) return 'Today';
    if (notifDate == yesterday) return 'Yesterday';
    
    // Returns e.g., "15 April"
    List<String> months = ['Jan', 'Feb', 'Mar', 'April', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]}';
  }

  // Calculates the "2H" or "1D" label
  String _formatTimeDifference(DateTime date) {
    final difference = DateTime.now().difference(date);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}M';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}H';
    } else {
      return '${difference.inDays}D';
    }
  }
}
