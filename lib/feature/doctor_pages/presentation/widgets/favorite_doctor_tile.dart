import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';

class FavoriteDoctorTile extends StatelessWidget {
  final String doctorName;
  final String speciality;
  final String image;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onBookTap;


  const FavoriteDoctorTile({
    super.key,
    required this.doctorName,
    required this.speciality,
    required this.image,
    required this.isFavorite,
    required this.onFavoriteTap, required this.onBookTap,
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  doctorName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.1,
                                    fontWeight: FontWeight.w500,
                                    color: appColor.Primary,
                                    fontFamily: "League Spartan",
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  speciality,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.1,
                                    fontWeight: FontWeight.w300,
                                    color: appColor.fontColor,
                                    fontFamily: "League Spartan",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: onFavoriteTap,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            height: 18,
                            width: 18,
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
                ),

                SizedBox(height: 5),

                SizedBox(
                  height: 25,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor.Primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    onPressed: onBookTap,
                    child: Center(
                      child: Text(
                        "Make Appointment",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: appColor.white,
                          fontFamily: "League Spartan",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
