import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

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
                SizedBox(
                  height: 20,
                ),
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
                SizedBox(
                  height: 10,
                ),
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
          )
      ),
    );
  }
}
