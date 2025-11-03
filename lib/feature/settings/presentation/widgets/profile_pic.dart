import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';


class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: 127,
            width: 127,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/icons/Doctors/images/doctor1.png"),
            ),
          ),

          Positioned(
            left: 95,
            top: 95,
            child: SvgPicture.asset("assets/icons/settings/edit_icon.svg"),
          ),
        ],
      ),
    );
  }
}
