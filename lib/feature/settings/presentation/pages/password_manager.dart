import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import '../../../../core/widget/CustomButton.dart';
import '../../../authentication/presentation/widgets/custom_input_field.dart';

class PasswordManager extends StatefulWidget {

  const PasswordManager({super.key});

  @override
  State<PasswordManager> createState() => _LogInState();
}

class _LogInState extends State<PasswordManager> {

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController currentPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Password Manager", onPressed: () {  },),
      backgroundColor: LightColorPalette.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        SizedBox(
                          width: 300,
                          child: Text(
                            "Current Password",
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
                        SizedBox(
                          width: 300,
                          child: Text(
                            "Forgot Password?",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 15,
                              color: LightColorPalette.primary,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        SizedBox(width: 300, child: Text(
                          "New Password",
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
                        SizedBox(height:20 ,),

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
            ],
          ),
        ),
      ),
    );
  }
}
