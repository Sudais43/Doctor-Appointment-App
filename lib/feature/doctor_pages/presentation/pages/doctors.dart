
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/widgets/doctor_rating_tile.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/widgets/doctor_tile.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/widgets/favorite_doctor_tile.dart';

import '../../../homePage/data/home_page_data.dart';
import '../../../homePage/domain/entities/doctor_info.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {

  late final List<DoctorInfo> allDoctors;
  String _selectedSort = "az";
  late List<DoctorInfo> doctor;

  /// 🔹 Sort icons and their meaning
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
      backgroundColor: const Color(0xFFF3F5FF),
      appBar: CustomAppBar(
          title: "Doctors",
          showSearch: true,
          showSort: true,
          onPressed: (){},
          onSearch: (){},
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children:
          //   _sortOptions.map((sort) {
          //     final bool isSelected = _selectedSort == sort["id"];
          //     return Padding(
          //       padding: const EdgeInsets.only(right: 7),
          //       child: GestureDetector(
          //         onTap: () => _sortDoctors(sort["id"]!),
          //         child: AnimatedContainer(
          //           duration: const Duration(milliseconds: 200),
          //           height: 33,
          //           padding: const EdgeInsets.all(10),
          //           decoration: BoxDecoration(
          //             color: isSelected ? LightColorPalette.primary : LightColorPalette.white,
          //             borderRadius: BorderRadius.circular(50),
          //             border: Border.all(color: Colors.blue),
          //             boxShadow: isSelected
          //                 ? [
          //               BoxShadow(
          //                 color: Colors.blue.withOpacity(0.3),
          //                 blurRadius: 8,
          //                 offset: const Offset(0, 3),
          //               ),
          //             ]
          //                 : [],
          //           ),
          //           child: SvgPicture.asset(
          //             sort["icon"]!,
          //             color: isSelected ? LightColorPalette.white : LightColorPalette.primary,
          //             // fit: BoxFit.fill,
          //           ),
          //         ),
          //       ),
          //     );
          //   }).toList(),
          // ),
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


        const SizedBox(height: 10),

          // 🔹 Doctor List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: doctor.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final doc = doctor[index];
                switch(_selectedSort){
                  case "rating":
                    return DoctorRatingTile(
                        doctorName: doc.name,
                        speciality: doc.Department,
                        image: doc.images,
                        isFavorite: doc.isFavorite
                    );

                  case "favorite":
                    return FavoriteDoctorTile(
                        doctorName: doc.name,
                        speciality: doc.Department,
                        image: doc.images,
                        isFavorite: doc.isFavorite
                    );

                  default:
                    return DoctorTile(
                        doctorName: doc.name,
                        speciality: doc.Department,
                        image: doc.images,
                        isFavorite: doc.isFavorite
                    );
                }
                //   Container(
                //   padding: const EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(20),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.blue.withOpacity(0.1),
                //         blurRadius: 8,
                //         offset: const Offset(0, 3),
                //       ),
                //     ],
                //   ),
                //   child: Row(
                //     children: [
                //       CircleAvatar(
                //         radius: 30,
                //         backgroundImage: AssetImage("assets/images/doctor_${index + 1}.png"),
                //       ),
                //       const SizedBox(width: 12),
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               doc.name,
                //               style: const TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 16,
                //               ),
                //             ),
                //             Text(
                //               doc.specialty,
                //               style: TextStyle(color: Colors.grey[600]),
                //             ),
                //           ],
                //         ),
                //       ),
                //       IconButton(
                //         onPressed: () {},
                //         icon: Icon(
                //           doc.isFavorite ? Icons.favorite : Icons.favorite_border,
                //           color: Colors.redAccent,
                //         ),
                //       )
                //     ],
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
