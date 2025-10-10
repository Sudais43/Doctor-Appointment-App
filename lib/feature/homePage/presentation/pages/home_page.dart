import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';
import 'package:skin_firts/core/widget/bottom_navigation_bar.dart';
import 'package:skin_firts/feature/homePage/domain/entities/doctor_info.dart';
import 'package:skin_firts/feature/homePage/presentation/widgets/doctor_tile.dart';
import 'package:skin_firts/feature/homePage/presentation/widgets/label_button.dart';

import '../../data/home_page_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> appointments = [
    {"day": "9", "label": "MON"},
    {"day": "10", "label": "TUE"},
    {"day": "11", "label": "WED"},
    {"day": "12", "label": "THU"},
    {"day": "13", "label": "FRI"},
    {"day": "14", "label": "SAT"},
  ];

  final List<String> appointmentDay = ["11", "13", "14"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            homeTopBar(),

            SizedBox(height: 10),
            Container(
              color: LightColorPalette.secondary,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(appointments.length, (index) {
                          final item = appointments[index];
                          final hasAppointment = appointmentDay.contains(
                            item["day"],
                          );
                          return Container(
                            height: 64,
                            width: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color:
                                  hasAppointment
                                      ? LightColorPalette.primary
                                      : LightColorPalette.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item["day"]!,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        hasAppointment
                                            ? LightColorPalette.white
                                            : LightColorPalette.black,
                                    fontFamily: "League Spartan",
                                  ),
                                ),
                                Text(
                                  // "Mon",
                                  item["label"]!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color:
                                        hasAppointment
                                            ? LightColorPalette.white
                                            : LightColorPalette.black,
                                    fontFamily: "League Spartan",
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  Container(
                    height: 123,
                    width: 299,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: LightColorPalette.white,
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),

            SizedBox(height: 10),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 32),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: DoctorTile(
                    doctorName: doctor.name,
                    department: doctor.Department,
                    messages: doctor.messages,
                    rating: doctor.rating,
                    isFavorite: doctor.isFavorite,
                    image: doctor.images,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  homeTopBar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    SizedBox(
                      height: 47,
                      width: 47,
                      child: CircleAvatar(
                        radius: 30,
                        child: SvgPicture.asset(
                          "assets/icons/BottomNaveBar/profile_icon.svg",
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi WelcomeBack",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: LightColorPalette.primary,
                            fontFamily: "League Spartan",
                          ),
                        ),
                        Text(
                          "MUhammad Sudais",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: LightColorPalette.black,
                            fontFamily: "League Spartan",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                child: Row(
                  children: [
                    Container(
                      height: 27,
                      width: 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: LightColorPalette.secondary,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/HomeScreen/notification_icon.svg",
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      height: 27,
                      width: 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: LightColorPalette.secondary,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/HomeScreen/ssetting_icon.svg",
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5),
                    LabelButton(
                      icon: SvgPicture.asset(
                        "assets/icons/HomeScreen/doctor_icon.svg",
                      ),
                      label: "Doctor",
                      onTap: () {},
                    ),
                    SizedBox(width: 25),
                    LabelButton(
                      icon: SvgPicture.asset(
                        "assets/icons/HomeScreen/favorite_outline_icon.svg",
                      ),
                      label: "Favorite",
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              searchBar(),
            ],
          ),
        ),
      ],
    );
  }

  searchBar() {
    return Container(
      height: 33,
      width: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: LightColorPalette.secondary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              print("Sudais KHan");
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: SizedBox(
                height: 26,
                width: 26,
                child: CircleAvatar(
                  backgroundColor: LightColorPalette.white,
                  child: SvgPicture.asset(
                    "assets/icons/HomeScreen/filter_icon.svg",
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset("assets/icons/HomeScreen/search_icon.svg"),
          ),
        ],
      ),
    );
  }
}
