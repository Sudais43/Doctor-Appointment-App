import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/color/light/LIghtColorPalette.dart';

class DoctorTile extends StatefulWidget {

  final String doctorName;
  final String department;
  final int messages;
  final double rating;
  final String image;
  final bool isFavorite;

  const DoctorTile({
    super.key,
    required this.doctorName,
    required this.department,
    required this.messages,
    required this.rating,
    required this.image,
    required this.isFavorite
  });

  @override
  State<DoctorTile> createState() => _DoctorTileState();
}

class _DoctorTileState extends State<DoctorTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: LightColorPalette.secondary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 57.56,
            width: 57.25,
            child: CircleAvatar(
              backgroundImage: Image.asset(widget.image).image,
            ),
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 211,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: LightColorPalette.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.doctorName,
                        // "Dr. Muhammad Sudais",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: LightColorPalette.primary,
                          height: 1,
                          fontFamily: "League Spartan",
                        ),
                      ),
                      Text(
                        widget.department,
                          // "Heart Surgeon",
                        style: TextStyle(
                          fontSize: 12,
                          height: 1,
                          fontWeight: FontWeight.w300,
                          color: LightColorPalette.black,
                          fontFamily: "League Spartan",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width: 43,
                    height: 18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: LightColorPalette.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: SvgPicture.asset("assets/icons/HomeScreen/star_filled_icon.svg"),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          widget.rating.toString(),
                          // "5",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: LightColorPalette.primary,
                            fontFamily: "League Spartan",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 05,),
                  Container(
                    width: 43,
                    height: 18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: LightColorPalette.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: SvgPicture.asset("assets/icons/HomeScreen/message_icon.svg"),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          widget.messages.toString(),
                          // "60",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: LightColorPalette.primary,
                            fontFamily: "League Spartan",
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 75,),

                  SizedBox(
                    height:19,
                    width: 19,
                    child: CircleAvatar(
                      backgroundColor: LightColorPalette.white,
                      child: SvgPicture.asset("assets/icons/HomeScreen/question_mark_icon.svg"),
                    ),
                  ),
                  SizedBox(width: 5,),
                  SizedBox(
                    height:19,
                    width: 19,
                    child: CircleAvatar(
                      backgroundColor: LightColorPalette.white,
                      child: SvgPicture.asset("assets/icons/HomeScreen/favorite_filled_icon.svg"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
