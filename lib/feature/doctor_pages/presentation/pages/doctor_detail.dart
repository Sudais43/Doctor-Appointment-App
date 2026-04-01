import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/Schedule/presentation/pages/schedule_screen.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/view_model/doctor_view_model.dart';

import '../../../homePage/domain/entities/doctor_info.dart';

class DoctorDetail extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String image;
  final String speciality;
  final double rating;
  final int reviews;
  final bool isFavorite;
  final List<dynamic> availability;

  const DoctorDetail({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.image,
    required this.speciality,
    required this.isFavorite,
    required this.availability,
    required this.rating,
    required this.reviews,
  });

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  late final List<DoctorInfo> allDoctors;
  String _selectedSort = "az";
  late List<DoctorInfo> doctor;
  late bool _isFavorite;

  final List<Map<String, String>> _sortOptions = [
    {"id": "az", "icon": "assets/icons/Doctors/sorting_icon.svg"},
    {"id": "rating", "icon": "assets/icons/Doctors/star_icon.svg"},
    {
      "id": "favorite",
      "icon": "assets/icons/Doctors/favorite_outline_icon.svg",
    },
    {"id": "male", "icon": "assets/icons/Doctors/male_icon.svg"},
    {"id": "female", "icon": "assets/icons/Doctors/female_icon.svg"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // allDoctors = List.from(doctors);
    // doctor = List.from(allDoctors);
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    context.read<DoctorViewModel>().toggleFavoriteStatus(widget.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Doctor Info",
        showSearch: true,
        showSort: true,
        onPressed: () {},
        onSearch: () {},
        onSort: () {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 340,
                  height: 283,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: appColor.secondary,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 140,
                            width: 140,
                            child: CircleAvatar(
                              backgroundImage:
                                  Image.asset(
                                    // "assets/icons/Doctors/images/doctor1.png",
                                    widget.image,
                                  ).image,
                            ),
                          ),
                          SizedBox(width: 30),
                          Column(
                            children: [
                              Container(
                                height: 27,
                                width: 108,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: appColor.Primary,
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: SizedBox(
                                        height: 21,
                                        width: 21,
                                        child: CircleAvatar(
                                          backgroundColor: appColor.secondary,
                                          child: SvgPicture.asset(
                                            "assets/icons/HomeScreen/badge_icon.svg",
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      "15 Years \n experience",
                                      style: TextStyle(
                                        fontSize: 12,
                                        height: 1,
                                        fontWeight: FontWeight.w300,
                                        color: appColor.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 108,
                                width: 108,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: appColor.Primary,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 12,
                                          height: 1.1,
                                          fontFamily: "LeagueSpartan",
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Focus: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                "The impact of hormonal imbalances on skin conditions, specializing in acne, hirsutism, and other skin disorders.",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 39,
                        width: 287,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: appColor.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.doctorName,
                              // "Dr. Alexander Bennett, Ph.D.",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 1,
                                color: appColor.Primary,
                                fontFamily: "LeagueSpartan",
                              ),
                            ),
                            Text(
                              widget.speciality,
                              // "Dermato-Genetics",
                              style: TextStyle(
                                fontSize: 13,
                                height: 1,
                                fontWeight: FontWeight.w300,
                                color: appColor.fontColor,
                                fontFamily: "LeagueSpartan",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
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
                                SizedBox(width: 3),
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
                          SizedBox(width: 6),
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
                                  widget.reviews.toString(),
                                  // "60",
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
                          SizedBox(width: 6),
                          Container(
                            height: 18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: appColor.white,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SvgPicture.asset(
                                    "assets/icons/HomeScreen/time_icon.svg",
                                  ),
                                ),
                                SizedBox(width: 5),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Mon-Sat / 9:00AM-5:00PM",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: appColor.Primary,
                                      fontFamily: "League Spartan",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // Icons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ScheduleScreen(
                                        doctorId: widget.doctorId,
                                        availability: widget.availability,
                                        doctorName: widget.doctorName,
                                        image: widget.image,
                                        speciality: widget.speciality,
                                        isFavorite: widget.isFavorite,
                                        rating: widget.rating,
                                        review: widget.reviews,
                                      ),
                                ),
                              );
                            },
                            child: Container(
                              width: 82,
                              height: 21,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: appColor.Primary,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/Doctors/calender_icon.svg",
                                    color: appColor.white,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    "Schedule",
                                    style: TextStyle(
                                      color: appColor.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "League Spartan",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Row(
                            children: [
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
                                      "assets/icons/HomeScreen/star_outline_icon.svg",
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
                                  child: GestureDetector(
                                    onTap: _toggleFavorite,
                                    child: CircleAvatar(
                                      backgroundColor: appColor.white,
                                      child: SvgPicture.asset(
                                        _isFavorite
                                            ? "assets/icons/HomeScreen/favorite_filled_icon.svg"
                                            : "assets/icons/Doctors/favorite_outline_icon.svg",
                                      ),
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
                ),

                SizedBox(height: 10),
                SizedBox(
                  width: 320,
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: appColor.Primary,
                    ),
                  ),
                ),

                SizedBox(
                  width: 320,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                    style: TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w300,
                      color: appColor.fontColor,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 320,
                  child: Text(
                    "Career Path",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: appColor.Primary,
                    ),
                  ),
                ),

                SizedBox(
                  width: 320,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                    style: TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w300,
                      color: appColor.fontColor,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 320,
                  child: Text(
                    "Highlights",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: appColor.Primary,
                    ),
                  ),
                ),

                SizedBox(
                  width: 320,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                    style: TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w300,
                      color: appColor.fontColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bookingButton(appColor),
    );
  }

  Widget _bookingButton(AppColor appColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ScheduleScreen(
                    doctorId: widget.doctorId,
                    availability: widget.availability,
                    doctorName: widget.doctorName,
                    image: widget.image,
                    speciality: widget.speciality,
                    isFavorite: widget.isFavorite,
                    rating: widget.rating,
                    review: widget.reviews,
                  ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: appColor.Primary),
        child: Text(
          "Book an Appointment",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: appColor.white,
          ),
        ),
      ),
    );
  }
}
