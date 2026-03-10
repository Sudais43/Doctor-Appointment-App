import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_ce/hive.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/feature/onboarding/presentation/pages/Registeration.dart';
import 'package:skin_firts/main_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Registration()),
      // );
      checkLoginStatus();
    });

    super.initState();
  }

  void checkLoginStatus() {
    final sessionBox = Hive.box('current_session');
    final isLoggedIn = sessionBox.get('isLoggedIn', defaultValue: false);

    if (isLoggedIn) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Registration()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColorPalette.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/splashScreen/splash_logo.svg"),
              SizedBox(height: 20),
              SizedBox(
                child: Text(
                  "Skin\nFirts",
                  style: TextStyle(
                    color: LightColorPalette.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w100,
                    height: 1.0,
                    fontFamily: "LeagueSpartan",
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Text(
                  "Dermatology center",
                  style: TextStyle(
                    fontSize: 12,
                    color: LightColorPalette.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: "LeagueSpartan",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
