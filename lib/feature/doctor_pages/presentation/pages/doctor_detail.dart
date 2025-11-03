import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';

import '../../../../core/color/light/LIghtColorPalette.dart';
import '../../../homePage/data/home_page_data.dart';
import '../../../homePage/domain/entities/doctor_info.dart';

class DoctorDetail extends StatefulWidget {
  const DoctorDetail({super.key});

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  late final List<DoctorInfo> allDoctors;
  String _selectedSort = "az";
  late List<DoctorInfo> doctor;

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
    allDoctors = List.from(doctors);
    doctor = List.from(allDoctors);
  }

  void _sortDoctors(String sortId) {
    setState(() {
      _selectedSort = sortId;
      doctor = List.from(allDoctors);

      switch (sortId) {
        case "az":
          allDoctors.sort((a, b) => a.name.compareTo(b.name));
          break;
        case "rating":
          allDoctors.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case "favorite":
          doctor = doctors.where((doc) => doc.isFavorite).toList();
          break;
        case "male":
          doctor = doctors.where((doc) => doc.gender == "male").toList();
          break;
        case "female":
          doctor = doctors.where((doc) => doc.gender == "female").toList();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 56.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 👇 Add your "Sort by" text here
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "Sort by:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: LightColorPalette.black,
                      ),
                    ),
                  ),
                  // 👇 Then spread your sort option buttons
                  ..._sortOptions.map((sort) {
                    final bool isSelected = _selectedSort == sort["id"];
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        onTap: () => _sortDoctors(sort["id"]!),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 25,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? LightColorPalette.primary
                                    : LightColorPalette.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.blue),
                            boxShadow:
                                isSelected
                                    ? [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                    : [],
                          ),
                          child: SvgPicture.asset(
                            sort["icon"]!,
                            color:
                                isSelected
                                    ? LightColorPalette.white
                                    : LightColorPalette.primary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            SizedBox(height: 10,),

            Container(
              width: 300,
              height: 283,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: LightColorPalette.secondary,
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
                                "assets/icons/Doctors/images/doctor1.png",
                              ).image,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Container(
                            height: 27,
                            width: 108,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: LightColorPalette.primary,
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
                                      backgroundColor:
                                          LightColorPalette.secondary,
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
                                    color: LightColorPalette.white,
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
                              color: LightColorPalette.primary,
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
                    width: 257,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: LightColorPalette.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dr. Alexander Bennett, Ph.D.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            height: 1,
                            color: LightColorPalette.primary,
                            fontFamily: "LeagueSpartan",
                          ),
                        ),
                        Text(
                          "Dermato-Genetics",
                          style: TextStyle(
                            fontSize: 13,
                            height: 1,
                            fontWeight: FontWeight.w300,
                            color: LightColorPalette.black,
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
                                color: LightColorPalette.primary,
                                fontFamily: "League Spartan",
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              child: SvgPicture.asset(
                                "assets/icons/HomeScreen/message_icon.svg",
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "60",
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
                      Container(
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: LightColorPalette.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: SvgPicture.asset(
                                "assets/icons/HomeScreen/time_icon.svg",
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Mon-Sat / 9:00AM-5:00PM",
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
                    ],
                  ),
                  SizedBox(height: 10),

                  // Icons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 82,
                        height: 21,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: LightColorPalette.primary,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/Doctors/calender_icon.svg",
                              color: LightColorPalette.white,
                            ),
                            SizedBox(width: 3),
                            Text(
                              "Schedule",
                              style: TextStyle(
                                color: LightColorPalette.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontFamily: "League Spartan",
                              ),
                            ),
                          ],
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
                                backgroundColor: LightColorPalette.white,
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
                                backgroundColor: LightColorPalette.white,
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
                                backgroundColor: LightColorPalette.white,
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
                              child: CircleAvatar(
                                backgroundColor: LightColorPalette.white,
                                child: SvgPicture.asset(
                                  "assets/icons/HomeScreen/favorite_filled_icon.svg",
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

            SizedBox(height: 10,),
            SizedBox(
              width: 282,
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: LightColorPalette.primary,
                ),
              ),
            ),

            SizedBox(
              width: 282,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                style: TextStyle(
                  fontSize: 12,
                  height: 1,
                  fontWeight: FontWeight.w300,
                  color: LightColorPalette.black,
                ),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: 282,
              child: Text(
                "Career Path",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: LightColorPalette.primary,
                ),
              ),
            ),

            SizedBox(
              width: 282,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                style: TextStyle(
                  fontSize: 12,
                  height: 1,
                  fontWeight: FontWeight.w300,
                  color: LightColorPalette.black,
                ),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: 282,
              child: Text(
                "Highlights",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: LightColorPalette.primary,
                ),
              ),
            ),

            SizedBox(
              width: 282,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                style: TextStyle(
                  fontSize: 12,
                  height: 1,
                  fontWeight: FontWeight.w300,
                  color: LightColorPalette.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
