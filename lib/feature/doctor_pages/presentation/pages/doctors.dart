import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/Schedule/presentation/pages/schedule_screen.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/view_model/doctor_view_model.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/widgets/doctor_tile.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/widgets/favorite_doctor_tile.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/widgets/tile_expansion.dart';

import '../../../homePage/domain/entities/doctor_info.dart';

import '../widgets/doctor_rating_tile.dart';

class DoctorListPage extends StatefulWidget {
  final String? favoriteSort;

  const DoctorListPage({super.key, this.favoriteSort});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  /// 🔹 Sort icons and their meaning
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<DoctorViewModel>(context, listen: false);
      if (widget.favoriteSort == 'favorite') {
        viewModel.setFavoriteOnlyFilter();
      } else {
        // When opening the general doctors page, we shouldn't show only favorites.
        // Other filters set by the user should be preserved.
        viewModel.setFavoriteFilter(false);
      }
    });
  }

  @override
  void dispose() {
    // final viewModel = context.read<DoctorViewModel>();
    // viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    final viewModel = context.watch<DoctorViewModel>();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Doctors",
        showSearch: true,
        showSort: true,
        onPressed: () {
          Navigator.pop(context);
        },
        onSearch: () {},
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
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
                      color: appColor.Primary,
                    ),
                  ),
                ),
                // 👇 Then spread your sort option buttons
                ..._sortOptions.map((sort) {
                  final id = sort["id"]!;
                  bool isSelected = false;
                  switch (id) {
                    case "az":
                      isSelected = viewModel.activeSort == "name";
                      break;
                    case "rating":
                      isSelected = viewModel.activeSort == "rating";
                      break;
                    case "favorite":
                      isSelected = viewModel.showFavoriteOnly;
                      break;
                    case "male":
                      isSelected = viewModel.activeGenderFilter == "Male";
                      break;
                    case "female":
                      isSelected = viewModel.activeGenderFilter == "Female";
                      break;
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: GestureDetector(
                      onTap: () {
                        switch (id) {
                          case "az":
                            viewModel.toggleAlphabeticalSort();
                            break;
                          case "rating":
                            viewModel.toggleRatingSort();
                            break;
                          case "favorite":
                            viewModel.toggleFavoriteFilter();
                            break;
                          case "male":
                            viewModel.setGenderFilter("Male");
                            break;
                          case "female":
                            viewModel.setGenderFilter("Female");
                            break;
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 33,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSelected ? appColor.Primary : appColor.white,
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
                          color: isSelected ? appColor.white : appColor.Primary,
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
          Expanded(child: _buildDoctorList(viewModel)),
        ],
      ),
    );
  }

  Widget _buildDoctorList(DoctorViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage.isNotEmpty) {
      return Center(child: Text(viewModel.errorMessage));
    }

    if (viewModel.doctors.isEmpty) {
      return const Center(child: Text("No doctors found."));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: viewModel.doctors.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final docData = viewModel.doctors[index];
        final doc = DoctorInfo(
          id: docData['_id'] ?? docData['id'] ?? '',
          name: docData['name'] ?? 'No Name',
          speciality: docData['specialization'] ?? 'Specialist',
          rating: (docData['rating'] as num? ?? 0.0).toDouble(),
          reviews: (docData['reviews'] as num? ?? 0).toInt(),
          isFavorite: docData['isFavorite'] ?? false,
          imageUrl: docData['imageUrl'] ?? '',
          gender: docData['gender'] ?? '',
          availability: docData['availability'] ?? [],
        );

        void onFavToggle() {
          viewModel.toggleFavoriteStatus(doc.id);
        }

        Widget tile;
        if (viewModel.activeSort == "rating") {
          tile = DoctorRatingTile(
            doctorName: doc.name,
            speciality: doc.speciality,
            image: doc.imageUrl,
            isFavorite: doc.isFavorite,
            rating: doc.rating,
            onFavoriteTap: onFavToggle,
            onBookTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ScheduleScreen(
                        doctorId: doc.id,
                        doctorName: doc.name,
                        availability: doc.availability,
                        image: doc.imageUrl,
                        speciality: doc.speciality,
                        isFavorite: doc.isFavorite,
                        rating: doc.rating,
                        review: doc.reviews,
                      ),
                ),
              );
            }, 
          );
        } else if (viewModel.showFavoriteOnly) {
          tile = FavoriteDoctorTile(
            doctorName: doc.name,
            speciality: doc.speciality,
            image: doc.imageUrl,
            isFavorite: doc.isFavorite,
            onFavoriteTap: onFavToggle,
            onBookTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ScheduleScreen(
                        doctorId: doc.id,
                        doctorName: doc.name,
                        availability: doc.availability,
                        image: doc.imageUrl,
                        speciality: doc.speciality,
                        isFavorite: doc.isFavorite,
                        rating: doc.rating,
                        review: doc.reviews,
                      ),
                ),
              );
            },
          );
        } else {
          tile = DoctorTile(
            doctorName: doc.name,
            speciality: doc.speciality,
            image: doc.imageUrl,
            isFavorite: doc.isFavorite,
            onFavoriteTap: onFavToggle,
            onBookTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ScheduleScreen(
                        doctorId: doc.id,
                        doctorName: doc.name,
                        availability: doc.availability,
                        image: doc.imageUrl,
                        speciality: doc.speciality,
                        isFavorite: doc.isFavorite,
                        rating: doc.rating,
                        review: doc.reviews,
                      ),
                ),
              );
            },
          );
        }
        return InkWell(
          onTap: () => viewModel.moveToDoctorDetail(context, doc),
          child: TileExpansion(child: tile),
        );
      },
    );
  }
}
