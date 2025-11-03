import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/authentication/presentation/widgets/custom_input_field.dart';
import 'package:skin_firts/feature/settings/presentation/widgets/profile_pic.dart';

import '../../../../core/color/light/LIghtColorPalette.dart';
import '../../../../core/widget/CustomButton.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile", onPressed: (){Navigator.pop(context);}),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ProfilePic(),
                SizedBox(height: 30),

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

                CustomInputField(
                  label: "Muhammad Sudais",
                  controller: nameController,
                ),

                SizedBox(height: 15),

                SizedBox(
                  width: 300,
                  child: Text(
                    "Date Of Birth",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "LeagueSpartan",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                CustomInputField(label: "5/6/2002", controller: dobController),

                SizedBox(height: 15),

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

                CustomInputField(label: "abc@gmail.com", controller: emailController),

                SizedBox(height: 15),

                SizedBox(
                  width: 300,
                  child: Text(
                    "Phone Number",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "LeagueSpartan",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                CustomInputField(
                  label: "12345",
                  controller: phoneController,
                ),

                SizedBox(height: 60),

                CustomButton(
                  width: 160,
                  height: 36,
                  BackgroundColor: LightColorPalette.primary,
                  text: "Update Profile",
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
