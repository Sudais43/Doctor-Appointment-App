import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/authentication/presentation/pages/login_2.dart';
import '../../../../core/widget/CustomButton.dart';
import '../widgets/custom_input_field.dart';

class SignUp extends StatefulWidget {

  const SignUp({super.key});

  @override
  State<SignUp> createState() => _LogInState();
}

class _LogInState extends State<SignUp> {

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "New Account", onPressed: () {  },),
      backgroundColor: LightColorPalette.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
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
                        "Full Name",
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

                    SizedBox(height: 10,),

                    SizedBox(
                      width: 300,
                      child: Text(
                        "Email",
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

                    SizedBox(height: 10,),
                    SizedBox(
                      width: 300,
                      child: Text(
                        "Mobile Number",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "LeagueSpartan",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 7),
                    CustomInputField(
                      label: "+9212345687",
                      controller: emailController,
                    ),

                    SizedBox(height: 10),

                    SizedBox(
                      width: 300,
                      child: Text(
                        "Date of Birth",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "LeagueSpartan",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 7),
                    CustomInputField(
                      label: "DD/MM/YYYY",
                      controller: emailController,
                    ),


                    SizedBox(height: 40,),

                    CustomButton(
                      text: "Sign Up",
                      BackgroundColor: LightColorPalette.primary,
                      onPressed: () {
                      },
                    ),

                    SizedBox(height: 20,),
                    SizedBox(
                      child: Text(
                        "By continuing, you agree to",
                        style: TextStyle(
                          fontSize: 12,
                          height: 0.5,
                          fontFamily: "LeagueSpartan",
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {

                          },
                          child: Text(
                            "Term of use",
                            style: TextStyle(
                              fontSize: 14,
                              height: 1,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w500,
                              color: LightColorPalette.primary,
                            ),
                          ),
                          ),
                        Text(
                          "and",
                          style: TextStyle(
                            fontSize: 12,
                            height: 1,
                            fontFamily: "LeagueSpartan",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextButton(
                          onPressed: () {

                          },
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                              fontSize: 14,
                              height: 1,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w500,
                              color: LightColorPalette.primary,
                            ),
                          ),
                        ),
                      ],
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
                            "assets/icons/Authentication/google_icon.svg",
                            fit: BoxFit.scaleDown,
                          ),
                        ),

                        SizedBox(width: 5),

                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: LightColorPalette.secondary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/Authentication/facebook_icon.svg",
                            fit: BoxFit.scaleDown,
                          ),
                        ),

                        SizedBox(width: 5),

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

                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "already have an account?",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "LeagueSpartan",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn2()));
                          },
                          child: Text(
                            "Sign In",
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
      ),
    );
  }
}
