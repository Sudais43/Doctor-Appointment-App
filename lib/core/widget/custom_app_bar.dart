import 'package:flutter/material.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(showBackButton)
            GestureDetector(
              child: BackButton(
                color: LightColorPalette.primary,
              ),
            )
          else
            SizedBox(width: 48),


          // SizedBox(width: 120),
          Text(
            title,
            style: TextStyle(
              fontSize: 27,
              fontFamily: "LeagueSpartan",
              fontWeight: FontWeight.w700,
              color: LightColorPalette.primary,
            ),
          ),

          SizedBox(width: 30),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 60);
}