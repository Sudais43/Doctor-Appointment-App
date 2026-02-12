import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';

class DoctorRatingTile extends StatelessWidget {
  final String doctorName;
  final String speciality;
  final String image;
  final bool isFavorite;

  const DoctorRatingTile({
    super.key,
    required this.doctorName,
    required this.speciality,
    required this.image,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    return Container(
      height: 106,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: appColor.secondary,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 70,
              width: 70,
              child: CircleAvatar(backgroundImage: Image.asset(image).image),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/Doctors/professional_badge_icon.svg",
                          ),

                          Text(
                            "Professional Doctor",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: appColor.Primary,
                              fontFamily: "League Spartan",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 70),
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
                            "5",
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
                  ],
                ),

                SizedBox(height: 5),

                Container(
                  height: 43,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: appColor.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          doctorName,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: appColor.Primary,
                            fontFamily: "League Spartan",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          speciality,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.1,
                            fontWeight: FontWeight.w300,
                            color: appColor.fontColor,
                            fontFamily: "League Spartan",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 46,
                      height: 22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: appColor.Primary,
                      ),
                      child: Center(
                        child: Text(
                          "Info",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: appColor.white,
                            fontFamily: "League Spartan",
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 105),

                    SizedBox(
                      width: 97,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 21,
                            width: 21,
                            child: CircleAvatar(
                              backgroundColor: appColor.white,
                              child: SvgPicture.asset(
                                "assets/icons/Doctors/calender_icon.svg",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 21,
                            width: 21,
                            child: CircleAvatar(
                              backgroundColor: appColor.white,
                              child: SvgPicture.asset(
                                "assets/icons/HomeScreen/info_mark.svg",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 21,
                            width: 21,
                            child: CircleAvatar(
                              backgroundColor: appColor.white,
                              child: SvgPicture.asset(
                                "assets/icons/Doctors/question_mark_icon.svg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 21,
                            width: 21,
                            child: CircleAvatar(
                              backgroundColor: appColor.white,
                              child: SvgPicture.asset(
                                isFavorite
                                    ? "assets/icons/HomeScreen/favorite_filled_icon.svg"
                                    : "assets/icons/Doctors/favorite_outline_icon.svg",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
