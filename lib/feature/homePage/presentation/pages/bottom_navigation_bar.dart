import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/feature/Schedule/presentation/pages/schedule_screen.dart';
import 'package:skin_firts/feature/chats/presentation/pages/chat_screen.dart';
import 'package:skin_firts/feature/homePage/presentation/pages/home_page.dart';
import 'package:skin_firts/feature/settings/presentation/pages/profile.dart';

class BottomNavigationbar1 extends StatelessWidget {
  // final Color BackgroundColor;

  const BottomNavigationbar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: BackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: LightColorPalette.primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/BottomNaveBar/home_icon.svg",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              ChatScreen(doctorName: "Muhammad Sudais"),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/BottomNaveBar/message_icon.svg",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/BottomNaveBar/profile_icon.svg",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScheduleScreen()),
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/BottomNaveBar/calender_icon.svg",
                ),
              ),
              // SvgPicture.asset("assets/icons/BottomNavigationBar/profile_nav_icon.svg"),
            ],
          ),
        ),
      ),
    );
  }
}
