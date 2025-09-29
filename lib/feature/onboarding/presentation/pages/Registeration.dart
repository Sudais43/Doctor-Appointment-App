import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';
import 'package:skin_firts/core/widget/CustomButton.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColorPalette.white,
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                SvgPicture.asset("assets/icons/splashScreen/register_logo.svg"),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 267,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    style: TextStyle(
                      color: LightColorPalette.black,
                      fontSize: 12,
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
                  height: 30,
                ),

                CustomButton(text: "Log In", onPressed: (){}),

                SizedBox( height: 10,),

                CustomButton(
                  BackgroundColor: LightColorPalette.secondary,
                    textStyle: TextStyle(
                      color: LightColorPalette.primary,
                    ),
                    text: "Sign In", onPressed: (){}
                )
              ],
            ),
          )
      ),
    );
  }
}
