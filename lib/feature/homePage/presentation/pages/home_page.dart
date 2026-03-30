import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/view_model/doctor_view_model.dart';
import 'package:skin_firts/feature/homePage/domain/entities/doctor_info.dart';
import 'package:skin_firts/feature/homePage/presentation/view_model/home_page_view_model.dart';
import 'package:skin_firts/feature/homePage/presentation/widgets/doctor_tile.dart';
import 'package:skin_firts/feature/homePage/presentation/widgets/label_button.dart';
import 'package:skin_firts/feature/homePage/presentation/widgets/upcoming_appointment_widget.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      Consumer<AppointmentViewModel>(
                        builder: (context, appointmentViewModel, child) {
                          final now = DateTime.now();
                          final List<Map<String, String>>
                          nextSixDays = List.generate(6, (index) {
                            final date = now.add(Duration(days: index));
                            return {
                              "day": date.day.toString(),
                              "label":
                                  DateFormat('E').format(date).toUpperCase(),
                              "fullDate": DateFormat('yyyy-MM-dd').format(date),
                            };
                          });

                          final appointmentDays =
                              appointmentViewModel.upcomingAppointments
                                  .map((app) {
                                    if (app.date.isNotEmpty) {
                                      final parsedDate = DateTime.tryParse(
                                        app.date,
                                      );
                                      if (parsedDate != null) {
                                        return DateFormat(
                                          'yyyy-MM-dd',
                                        ).format(parsedDate.toLocal());
                                      }
                                      final match = RegExp(
                                        r'\d+',
                                      ).firstMatch(app.date);
                                      if (match != null) {
                                        return match.group(0);
                                      }
                                    }
                                    return null;
                                  })
                                  .where((day) => day != null)
                                  .toSet()
                                  .toList();

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ...List.generate(nextSixDays.length, (index) {
                                  final item = nextSixDays[index];
                                  final hasAppointment =
                                      appointmentDays.contains(
                                        item["fullDate"],
                                      ) ||
                                      appointmentDays.contains(item["day"]);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          );
                        },
                      ),

                      SizedBox(height: 10),
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
                        final docData = doctorViewModel.homeDoctors[index];
                        final doc = DoctorInfo(
                          id: docData['_id'] ?? docData['id'] ?? '',
                          name: docData['name'] ?? 'No Name',
                          speciality: docData['specialization'] ?? 'Specialist',
                          rating: (docData['rating'] as num? ?? 0.0).toDouble(),
                          reviews:
                              (docData['reviews'] as num? ?? 0).toInt(),
                          isFavorite: docData['isFavorite'] ?? false,
                          imageUrl: docData['imageUrl'] ?? '',
                          gender: docData['gender'] ?? '',
                          availability: docData['availability'] ?? [],
                        );
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap:
                                () => doctorViewModel.moveToDoctorDetail(
                                  context,
                                  doc,
                                ),
                            child: DoctorTile1(
                              doctorName: doc.name,
                              specialization: doc.speciality,
                              reviews: doc.reviews,
                              rating: doc.rating,
                              imageUrl: doc.imageUrl,
                              isFavorite: doc.isFavorite,
                              onFavoriteTap: () {
                                doctorViewModel.toggleFavoriteStatus(doc.id);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
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
