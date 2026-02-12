import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_firts/core/theme/color_palette.dart';

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
      height: 60,
      width: 350,
      decoration: BoxDecoration(
        color: LightColorPalette.primary,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: LightColorPalette.iconColor,
          unselectedItemColor: LightColorPalette.white,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/BottomNaveBar/home_icon.svg", fit: BoxFit.scaleDown),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/BottomNaveBar/message_icon.svg", fit: BoxFit.scaleDown),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/BottomNaveBar/profile_icon.svg", fit: BoxFit.scaleDown),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/BottomNaveBar/calender_icon.svg", fit: BoxFit.scaleDown),
              label: "",
            ),
          ]
      ),
    );
  }
}
