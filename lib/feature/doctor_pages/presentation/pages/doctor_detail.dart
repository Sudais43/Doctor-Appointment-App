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
    {"id": "favorite", "icon": "assets/icons/Doctors/favorite_outline_icon.svg"},
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
      appBar: CustomAppBar(title: "Doctor Info",
          showSearch: true,
          showSort: true,
          onPressed: (){},
          onSearch: (){},
          onSort: (){},
      ),
      body: SafeArea(
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 👇 Add your "Sort by" text here
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "Sort by:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: LightColorPalette.primary,
                        ),
                      ),
                    ),
                    // 👇 Then spread your sort option buttons
                    ..._sortOptions.map((sort) {
                      final bool isSelected = _selectedSort == sort["id"];
                      return Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: GestureDetector(
                          onTap: () => _sortDoctors(sort["id"]!),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 33,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? LightColorPalette.primary
                                  : LightColorPalette.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.blue),
                              boxShadow: isSelected
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
                              color: isSelected
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

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: LightColorPalette.secondary,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 140,
                          width: 140,
                          child: CircleAvatar(
                            backgroundImage: Image.asset("assets/icons/Doctors/images/doctor1.png").image,
                          ),
                        ),
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
                                        backgroundColor: LightColorPalette.secondary,
                                        child: SvgPicture.asset("assets/icons/Doctors/professional_badge_icon.svg"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3,),
                                  Text(
                                    "15 Years \n experience",
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1,
                                      fontWeight: FontWeight.w300,
                                      color: LightColorPalette.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
