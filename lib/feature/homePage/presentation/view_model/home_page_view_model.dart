import 'package:flutter/material.dart';
import 'package:skin_firts/core/navigation/slide_transition.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/pages/doctors.dart';
import 'package:skin_firts/feature/settings/presentation/pages/notification.dart';
import 'package:skin_firts/feature/settings/presentation/pages/profile.dart';
import 'package:skin_firts/feature/settings/presentation/pages/setting_page.dart';

class HomePageViewModel extends ChangeNotifier {
  void moveToProfileSetting(BuildContext context) {
    Navigator.push(
      context,
      SlideRoute(page: ProfileScreen()),
      // MaterialPageRoute(builder: (context) => ProfileScreen()),
    );

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
}
