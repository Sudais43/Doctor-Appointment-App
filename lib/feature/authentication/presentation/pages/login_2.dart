import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import '../../../../core/widget/CustomButton.dart';
import '../widgets/custom_input_field.dart';

class LogIn2 extends StatefulWidget {

  const LogIn2({super.key});

  @override
  State<LogIn2> createState() => _LogInState();
}

class _LogInState extends State<LogIn2> {

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Hello!"),
      backgroundColor: LightColorPalette.white,
      body: SafeArea(
        child: Column(
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
                      "Welcome",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "LeagueSpartan",
                        fontWeight: FontWeight.w600,
                        color: LightColorPalette.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: 30),
                  SizedBox(
                    width: 300,
                    child: Text(
                      "Email or Mobile Number",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "LeagueSpartan",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  CustomInputField(
                    label: "email@email.com",
                    controller: emailController,
                  ),

                  SizedBox(height: 10),

                  SizedBox(width: 300, child: Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "LeagueSpartan",
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                  SizedBox(height: 7),
                  CustomInputField(
                    obscureText: true,
                    label: "Password",
                    controller: passwordController,
                    suffixIcon: SvgPicture.asset("assets/icons/Authentication/show_pass_icon.svg", fit: BoxFit.scaleDown),
                  ),
                  SizedBox(height:10 ,),
                  SizedBox(
                    width: 300,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "LeagueSpartan",
                          fontWeight: FontWeight.w500,
                          color: LightColorPalette.primary,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40,),

                  CustomButton(
                    text: "Log In",
                    BackgroundColor: LightColorPalette.primary,
                    onPressed: () {
                    },
                  ),

                  SizedBox(height: 20,),
                  SizedBox(
                    child: Text(
                      "or",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "LeagueSpartan",
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: LightColorPalette.secondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Authentication/finger_icon.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "LeagueSpartan",
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextButton(
                        onPressed: () {

                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "LeagueSpartan",
                            fontWeight: FontWeight.w500,
                            color: LightColorPalette.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
