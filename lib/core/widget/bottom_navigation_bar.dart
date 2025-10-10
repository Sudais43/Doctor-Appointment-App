import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';

class BottomNavBar extends StatelessWidget {

  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: LightColorPalette.primary,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: LightColorPalette.primary,
          selectedItemColor: LightColorPalette.iconColor,
          unselectedItemColor: LightColorPalette.white,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/BottomNaveBar/home_icon.svg", fit: BoxFit.scaleDown),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/BottomNaveBar/message_icon.svg", fit: BoxFit.scaleDown),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/BottomNaveBar/profile_icon.svg", fit: BoxFit.scaleDown),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/BottomNaveBar/calender_icon.svg", fit: BoxFit.scaleDown),
            ),
          ]
      ),
    );
  }
}
