import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/view_model/doctor_view_model.dart';
import 'package:skin_firts/feature/homePage/presentation/view_model/home_page_view_model.dart';
import 'package:skin_firts/feature/homePage/presentation/widgets/doctor_tile.dart';
import 'package:skin_firts/feature/homePage/presentation/widgets/label_button.dart';
import 'package:skin_firts/feature/homePage/presentation/widgets/upcoming_appointment_widget.dart';

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
    final sessionBox = Hive.box('current_session');
    final userName = sessionBox.get('userName', defaultValue: 'User Khan');
    final appColor = context.appColors;
    return Scaffold(
      // bottomNavigationBar: BottomNavigationbar1(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<DoctorViewModel>().fetchHomeDoctors();
            context.read<AppointmentViewModel>().fetchUpcomingAppointments();
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                homeTopBar(appColor, userName),
                SizedBox(height: 10),
                Container(
                  color: appColor.secondary,
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
                                          ? appColor.Primary
                                          : appColor.white,
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

                      // Container(
                      //   height: 123,
                      //   width: 315,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: LightColorPalette.white,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: UpcomingAppointmentWidget(),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                Consumer<DoctorViewModel>(
                  builder: (context, doctorViewModel, child) {
                    if (doctorViewModel.isHomeLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (doctorViewModel.homeDoctors.isEmpty) {
                      return Center(child: Text("No Doctors Found"));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doctorViewModel.homeDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = doctorViewModel.homeDoctors[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: DoctorTile1(
                            doctorName: doctor['name'],
                            specialization:
                                doctor['specialization'] ?? 'Specialist',
                            reviewsCount: doctor['reviewsCount'] ?? 0,
                            rating:
                                (doctor['rating'] as num? ?? 0.0).toDouble(),
                            imageUrl:
                                doctor['imageUrl'] ??
                                '', // Fixed typo: imagesUrl -> imageUrl
                            // Provide a fallback just in case 'isFavorite' is missing
                            isFavorite: doctor['isFavorite'] ?? false,
                            onFavoriteTap: () {
                              doctorViewModel.toggleFavoriteStatus(
                                doctor['_id'] ?? doctor['id'] ?? '',
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                // ListView.builder(
                //   padding: EdgeInsets.symmetric(horizontal: 32),
                //   shrinkWrap: true,
                //   physics: BouncingScrollPhysics(),
                //   itemCount: doctors.length,
                //   itemBuilder: (context, index) {
                //     final doctor = doctors[index];
                //     return Padding(
                //       padding: const EdgeInsets.only(bottom: 8.0),
                //       child: DoctorTile(
                //         doctorName: doctor.name,
                //         department: doctor.speciality,
                //         messages: doctor.reviews,
                //         rating: doctor.rating,
                //         isFavorite: doctor.isFavorite,
                //         image: doctor.imageUrl,
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  homeTopBar(AppColor appColor, String userName) {
    return Column(
      children: [
        SizedBox(height: 20),
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
                            color: appColor.Primary,
                            fontFamily: "League Spartan",
                          ),
                        ),
                        Text(
                          userName,
                          // "MUhammad Sudais",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: appColor.fontColor,
                            fontFamily: "League Spartan",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Consumer<HomePageViewModel>(
                builder: (context, homePageViewModel, child) {
                  return SizedBox(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => NotificationScreen(),
                            //   ),
                            // );
                            homePageViewModel.moveToNotificationPage(context);
                          },
                          child: Container(
                            height: 27,
                            width: 27,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: appColor.secondary,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/HomeScreen/notification_icon.svg",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ProfileScreen(),
                            //   ),
                            // );
                            homePageViewModel.moveToProfileSetting(context);
                          },
                          child: Container(
                            height: 27,
                            width: 27,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: appColor.secondary,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/HomeScreen/ssetting_icon.svg",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Consumer<HomePageViewModel>(
          builder: (context, homePageVM, child) {
            return Padding(
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
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => DoctorListPage(),
                            //   ),
                            // );
                            homePageVM.moveToDoctorPage(context);
                          },
                        ),
                        SizedBox(width: 25),
                        LabelButton(
                          icon: SvgPicture.asset(
                            "assets/icons/HomeScreen/favorite_outline_icon.svg",
                          ),
                          label: "Favorite",
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder:
                            //         (context) =>
                            //             DoctorListPage(favoriteSort: "favorite"),
                            //   ),
                            // );
                            homePageVM.moveToFavoritePage(context);
                          },
                        ),
                      ],
                    ),
                  ),

                  searchBar(appColor),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  searchBar(AppColor appColor) {
    return Container(
      height: 33,
      width: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: appColor.secondary,
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
                  backgroundColor: appColor.white,
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
