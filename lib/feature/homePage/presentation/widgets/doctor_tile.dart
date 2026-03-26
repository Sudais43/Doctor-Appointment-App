import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';

import '../../../../core/theme/color_palette.dart';

class DoctorTile1 extends StatefulWidget {
  final String doctorName;
  final String specialization;
  final int reviewsCount;
  final double rating;
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const DoctorTile1({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.reviewsCount,
    required this.rating,
    required this.imageUrl,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  State<DoctorTile1> createState() => _DoctorTileState();
}

class _DoctorTileState extends State<DoctorTile1> {
  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    return Container(
      height: 74,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: appColor.secondary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 57.56,
            width: 57.25,
            child: CircleAvatar(
              backgroundImage: Image.asset(widget.imageUrl).image,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 211,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: appColor.white,
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
                          color: appColor.Primary,
                          height: 1,
                          fontFamily: "League Spartan",
                        ),
                      ),
                      Text(
                        widget.specialization,
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
              SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    width: 43,
                    height: 18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: appColor.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: SvgPicture.asset(
                            "assets/icons/HomeScreen/star_filled_icon.svg",
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.rating.toString(),
                          // "5",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: appColor.Primary,
                            fontFamily: "League Spartan",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 05),
                  Container(
                    width: 43,
                    height: 18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: appColor.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: SvgPicture.asset(
                            "assets/icons/HomeScreen/message_icon.svg",
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.reviewsCount.toString(),
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

                  SizedBox(width: 75),

                  SizedBox(
                    height: 19,
                    width: 19,
                    child: CircleAvatar(
                      backgroundColor: appColor.white,
                      child: SvgPicture.asset(
                        "assets/icons/HomeScreen/question_mark_icon.svg",
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.onFavoriteTap,
                    child: SizedBox(
                      height: 19,
                      width: 19,
                      child: CircleAvatar(
                        backgroundColor: appColor.white,
                        child: SvgPicture.asset(
                          widget.isFavorite
                              ? "assets/icons/HomeScreen/favorite_filled_icon.svg"
                              : "assets/icons/Doctors/favorite_outline_icon.svg",
                        ),
                      ),
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
