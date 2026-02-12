import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';

class DoctorTile extends StatelessWidget {
  final String doctorName;
  final String speciality;
  final String image;
  final bool isFavorite;

  const DoctorTile({
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
      height: 131,
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
              height: 107,
              width: 107,
              child: CircleAvatar(backgroundImage: Image.asset(image).image),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Text(
                    doctorName,
                    // "Muhammad Sudais",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: appColor.Primary,
                      fontFamily: "League Spartan",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    speciality,
                    // "Heart Surgeon",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: appColor.fontColor,
                      fontFamily: "League Spartan",
                    ),
                  ),
                ),

                Row(
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

                    SizedBox(width: 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: SizedBox(
                        height: 21,
                        width: 21,
                        child: CircleAvatar(
                          backgroundColor: appColor.white,
                          child: SvgPicture.asset(
                            "assets/icons/Doctors/calender_icon.svg",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: SizedBox(
                        height: 21,
                        width: 21,
                        child: CircleAvatar(
                          backgroundColor: appColor.white,
                          child: SvgPicture.asset(
                            "assets/icons/HomeScreen/info_mark.svg",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: SizedBox(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: SizedBox(
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
