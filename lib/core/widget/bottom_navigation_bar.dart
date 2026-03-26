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
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: Container(
        height: 60,
        width: 280,
        // padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: appColor.Primary,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              0,
              "assets/icons/BottomNaveBar/home_icon.svg",
              context,
            ),
            _buildNavItem(
              1,
              "assets/icons/BottomNaveBar/message_icon.svg",
              context,
            ),
            _buildNavItem(
              2,
              "assets/icons/BottomNaveBar/profile_icon.svg",
              context,
            ),
            _buildNavItem(
              3,
              "assets/icons/BottomNaveBar/calender_icon.svg",
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, BuildContext context) {
    final isSelected = currentIndex == index;
    final appColor = context.appColors;
    return IconButton(
      onPressed: () => onTap(index),
      icon: SvgPicture.asset(
        iconPath,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(
          isSelected ? appColor.iconColor : appColor.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
