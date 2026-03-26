import 'package:flutter/material.dart';
import 'package:skin_firts/core/widget/bottom_navigation_bar.dart';
import 'package:skin_firts/feature/Schedule/presentation/pages/schedule_screen.dart';
import 'package:skin_firts/feature/appointment/presentation/pages/all_appointment.dart';
import 'package:skin_firts/feature/chats/presentation/pages/chat_screen.dart';
import 'package:skin_firts/feature/homePage/presentation/pages/home_page.dart';
import 'package:skin_firts/feature/settings/presentation/pages/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> pages = [
    HomePage(),
    ChatScreen(doctorName: "Sudais"),
    ProfileScreen(),
    // ScheduleScreen(),
    AllAppointmentsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (int value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      body: SafeArea(child: pages[_selectedIndex]),
    );
  }
}
