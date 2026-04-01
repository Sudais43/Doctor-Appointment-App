import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';
import 'package:skin_firts/feature/authentication/presentation/view_model/auth_view_model.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/pages/doctors.dart';
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
  final TextEditingController _searchController = TextEditingController();

  @override
  initState() {
    super.initState();
    context.read<AuthViewModel>().syncFcmToken();
    Future.microtask(() {
      context.read<DoctorViewModel>().fetchHomeDoctors();
      context.read<AppointmentViewModel>().fetchUpcomingAppointments();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<DoctorViewModel>().fetchHomeDoctors();
            context.read<AppointmentViewModel>().fetchUpcomingAppointments();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: Hive.box('current_session').listenable(keys: ['userName', 'profilePic']),
                  builder: (context, sessionBox, child) {
                    final userName = sessionBox.get('userName', defaultValue: 'User Khan');
                    final profilePic = sessionBox.get('profilePic') as String?;
                    return _homeTopBar(appColor, userName, profilePic);
                  },
                ),
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
                GridView.count(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _catButton(
                      appColor,
                      "Dermatology",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    DoctorListPage(category: "Dermatology"),
                          ),
                        );
                      },
                      "assets/icons/HomeScreen/png/dermatology.png",
                    ),
                    _catButton(
                      appColor,
                      "Cardiology",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    DoctorListPage(category: "Cardiology"),
                          ),
                        );
                      },
                      "assets/icons/HomeScreen/png/heart.png",
                    ),
                    _catButton(
                      appColor,
                      "pediatrics",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    DoctorListPage(category: "Pediatrics"),
                          ),
                        );
                      },
                      "assets/icons/HomeScreen/png/pediatrics.png",
                    ),
                    _catButton(
                      appColor,
                      "Neurology",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    DoctorListPage(category: "Neurology"),
                          ),
                        );
                      },
                      "assets/icons/HomeScreen/png/brain.png",
                    ),
                  ],
                ),
                // Consumer<DoctorViewModel>(
                //   builder: (context, doctorViewModel, child) {
                //     if (doctorViewModel.isHomeLoading) {
                //       return Center(child: CircularProgressIndicator());
                //     }
                //     if (doctorViewModel.homeDoctors.isEmpty) {
                //       return Center(child: Text("No Doctors Found"));
                //     }
                //     return ListView.builder(
                //       padding: const EdgeInsets.symmetric(horizontal: 32),
                //       shrinkWrap: true,
                //       physics: const NeverScrollableScrollPhysics(),
                //       itemCount: doctorViewModel.homeDoctors.length,
                //       itemBuilder: (context, index) {
                //         final docData = doctorViewModel.homeDoctors[index];
                //         final doc = DoctorInfo(
                //           id: docData['_id'] ?? docData['id'] ?? '',
                //           name: docData['name'] ?? 'No Name',
                //           speciality: docData['specialization'] ?? 'Specialist',
                //           rating: (docData['rating'] as num? ?? 0.0).toDouble(),
                //           reviews:
                //               (docData['reviews'] as num? ?? 0).toInt(),
                //           isFavorite: docData['isFavorite'] ?? false,
                //           imageUrl: docData['imageUrl'] ?? '',
                //           gender: docData['gender'] ?? '',
                //           availability: docData['availability'] ?? [],
                //         );
                //         return Padding(
                //           padding: const EdgeInsets.only(bottom: 8.0),
                //           child: GestureDetector(
                //             onTap:
                //                 () => doctorViewModel.moveToDoctorDetail(
                //                   context,
                //                   doc,
                //                 ),
                //             child: DoctorTile1(
                //               doctorName: doc.name,
                //               specialization: doc.speciality,
                //               reviews: doc.reviews,
                //               rating: doc.rating,
                //               imageUrl: doc.imageUrl,
                //               isFavorite: doc.isFavorite,
                //               onFavoriteTap: () {
                //                 doctorViewModel.toggleFavoriteStatus(doc.id);
                //               },
                //             ),
                //           ),
                //         );
                //       },
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

  Widget _catButton(
    AppColor appColor,
    String text,
    VoidCallback onTap,
    String image,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: appColor.secondary,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(image, fit: BoxFit.scaleDown),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: appColor.fontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeTopBar(AppColor appColor, String userName, String? rawProfilePic) {
    final profilePic = rawProfilePic?.replaceAll('\\', '/');

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
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            profilePic != null && profilePic.isNotEmpty
                                ? NetworkImage(
                                  profilePic.startsWith('http')
                                      ? profilePic
                                      : "http://10.0.2.2:3000${profilePic.startsWith('/') ? '' : '/'}$profilePic",
                                )
                                : null,
                        child:
                            profilePic == null || profilePic.isEmpty
                                ? SvgPicture.asset(
                                  "assets/icons/BottomNaveBar/profile_icon.svg",
                                )
                                : null,
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

                  _searchBar(appColor),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _searchBar(AppColor appColor) {
    return SizedBox(
      height: 33,
      width: 190,
      child: TextField(
        controller: _searchController,
        style: TextStyle(fontSize: 14, color: appColor.fontColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: "Search...",
          hintStyle: TextStyle(
            fontSize: 14,
            color: appColor.fontColor?.withOpacity(0.7),
          ),
          filled: true,
          fillColor: appColor.secondary,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(3),
            child: CircleAvatar(
              backgroundColor: appColor.white,
              child: SvgPicture.asset(
                "assets/icons/HomeScreen/filter_icon.svg",
                // height: 16,
              ),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              if (_searchController.text.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            DoctorListPage(searchQuery: _searchController.text),
                  ),
                );
              }
            },
            child: SvgPicture.asset(
              "assets/icons/HomeScreen/search_icon.svg",
              fit: BoxFit.scaleDown,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorListPage(searchQuery: value),
              ),
            );
          }
        },
      ),
    );
  }
}
