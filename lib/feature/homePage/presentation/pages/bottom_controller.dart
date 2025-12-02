import 'package:flutter/material.dart';
import 'package:skin_firts/core/widget/bottom_navigation_bar.dart';
import 'package:skin_firts/feature/homePage/presentation/pages/home_page.dart';
import 'package:skin_firts/feature/settings/presentation/pages/profile.dart';

class BottomController extends StatefulWidget {
  const BottomController({super.key});

  @override
  State<BottomController> createState() => _BottomControllerState();
}

class _BottomControllerState extends State<BottomController> {

  int _currentIndex = 0;

  final List<Widget> _pages =[
    HomePage(),
    const Center(child: Text('Chat Page')),
    ProfileScreen(),
    const Center(child: Text('Schedule Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(child: _pages[_currentIndex]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: BottomNavBar(
                currentIndex: _currentIndex,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
