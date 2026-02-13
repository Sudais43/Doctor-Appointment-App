import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    return Container(
      height: 60,
      width: 300,
      decoration: BoxDecoration(
        color: appColor.Primary,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedItemColor: appColor.iconColor,
        unselectedItemColor: appColor.white,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/BottomNaveBar/home_icon.svg",
              fit: BoxFit.scaleDown,
              color: currentIndex == 0 ? appColor.iconColor : appColor.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/BottomNaveBar/message_icon.svg",
              fit: BoxFit.scaleDown,
              color: currentIndex == 1 ? appColor.iconColor : appColor.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/BottomNaveBar/profile_icon.svg",
              fit: BoxFit.scaleDown,
              color: currentIndex == 2 ? appColor.iconColor : appColor.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/BottomNaveBar/calender_icon.svg",
              fit: BoxFit.scaleDown,
              color: currentIndex == 3 ? appColor.iconColor : appColor.white,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
