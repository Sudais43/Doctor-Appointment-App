import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:skin_firts/core/navigation/slide_transition.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/pages/doctors.dart';
import 'package:skin_firts/feature/homePage/domain/entities/app_notification.dart';
import 'package:skin_firts/feature/settings/presentation/pages/notification.dart';
import 'package:skin_firts/feature/settings/presentation/pages/profile.dart';

class HomePageViewModel extends ChangeNotifier {
  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;

  // 2. Initialize and load past notifications
  Future<void> initNotifications() async {
    // Open a new Hive box specifically for notifications
    final box = await Hive.openBox('notifications_box');

    // Load saved notifications
    final savedNotifications = box.get('history', defaultValue: []);
    _notifications =
        (savedNotifications as List)
            .map((e) => AppNotification.fromMap(e))
            .toList();

    notifyListeners(); // Update the UI

    // 3. Listen for NEW notifications while the app is open (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _addNewNotification(
          message.notification!.title ?? "New Alert",
          message.notification!.body ?? "You have a new message.",
        );
      }
    });
  }

  // 4. Helper method to add a new notification and save it to Hive
  void _addNewNotification(String title, String body) {
    final newNotif = AppNotification(
      title: title,
      body: body,
      timestamp: DateTime.now(),
    );

    // Add to the top of the list
    _notifications.insert(0, newNotif);
    notifyListeners();

    // Save the updated list to Hive
    final box = Hive.box('notifications_box');
    final mappedList = _notifications.map((n) => n.toMap()).toList();
    box.put('history', mappedList);
  }

  void removeNotification(AppNotification notification) {
    // 1. Remove from the local list
    _notifications.remove(notification);
    notifyListeners(); // Updates the UI instantly

    // 2. Save the updated list back to Hive
    final box = Hive.box('notifications_box');
    final mappedList = _notifications.map((n) => n.toMap()).toList();
    box.put('history', mappedList);
  }

  void markAllAsRead() {
    // 1. Update the local list
    for (var notif in _notifications) {
      notif.isRead =
          true; // Make sure 'isRead' is a mutable property in AppNotification
    }
    notifyListeners();

    // 2. Save the updated list back to Hive
    final box = Hive.box('notifications_box');
    final mappedList = _notifications.map((n) => n.toMap()).toList();
    box.put('history', mappedList);
  }

  void moveToProfileSetting(BuildContext context) {
    Navigator.push(context, SlideRoute(page: ProfileScreen()));
  }

  void moveToNotificationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationScreen()),
    );
  }

  void moveToDoctorPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DoctorListPage()),
    );
  }

  void moveToFavoritePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorListPage(favoriteSort: "favorite"),
      ),
    );
  }

  // Add these to your HomePageViewModel
  void moveToCategory(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorListPage(category: category),
      ),
    );
  }

  void performSearch(BuildContext context, String query) {
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorListPage(searchQuery: query),
        ),
      );
    }
  }
}
