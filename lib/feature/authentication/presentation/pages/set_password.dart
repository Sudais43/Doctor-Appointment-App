import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import '../../../../core/widget/CustomButton.dart';
import '../widgets/custom_input_field.dart';

class SetPassword extends StatefulWidget {

  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _LogInState();
}

class _LogInState extends State<SetPassword> {

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Set Password"),
      backgroundColor: LightColorPalette.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    // SizedBox(
                    //   width: 322,
                    //   child: Text(
                    //     "Welcome",
                    //     style: TextStyle(
                    //       fontSize: 24,
                    //       fontFamily: "LeagueSpartan",
                    //       fontWeight: FontWeight.w600,
                    //       color: LightColorPalette.primary,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 322,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. ",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "LeagueSpartan",
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      width: 300,
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "LeagueSpartan",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 7),
                    CustomInputField(
                      label: "**********",
                      controller: passwordController,
                      obscureText: true,
                      suffixIcon: SvgPicture.asset("assets/icons/Authentication/show_pass_icon.svg", fit: BoxFit.scaleDown),
                    ),

                    SizedBox(height: 10),

                    SizedBox(width: 300, child: Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "LeagueSpartan",
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                    SizedBox(height: 7),
                    CustomInputField(
                      obscureText: true,
                      label: "**********",
                      controller: confirmPasswordController,
                      suffixIcon: SvgPicture.asset("assets/icons/Authentication/show_pass_icon.svg", fit: BoxFit.scaleDown),
                    ),
                    SizedBox(height:10 ,),


                    SizedBox(height: 40,),

                    CustomButton(
                      text: "Log In",
                      BackgroundColor: LightColorPalette.primary,
                      onPressed: () {
                      },
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
