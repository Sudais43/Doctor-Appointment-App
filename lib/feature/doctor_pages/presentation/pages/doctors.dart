import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/view_model/doctor_view_model.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/widgets/doctor_tile.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/widgets/favorite_doctor_tile.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/widgets/tile_expansion.dart';

import '../../../homePage/domain/entities/doctor_info.dart';

import '../widgets/doctor_rating_tile.dart';

class DoctorListPage extends StatefulWidget {
  final String? favoriteSort;
  final String? category;
  final String? searchQuery;

  const DoctorListPage({super.key, this.favoriteSort, this.category, this.searchQuery});

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

      if (widget.searchQuery != null) {
        viewModel.setSearchQuery(widget.searchQuery!);
      } else {
        viewModel.setSearchQuery('');
      }

      if (widget.category != null) {
        viewModel.setSpecializationFilter(widget.category!);
      } else if (widget.favoriteSort == 'favorite') {
        viewModel.setFavoriteOnlyFilter();
      } else {
        // When opening the general doctors page, we shouldn't show only favorites.
        // Other filters set by the user should be preserved.
        viewModel.setFavoriteFilter(false);
        viewModel.setSpecializationFilter("");
      }
    });
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
      body: 
      Column(
        children: [
          const SizedBox(height: 8),
          _buildSortRow(appColor, viewModel),
          const SizedBox(height: 10),
          Expanded(child: _buildDoctorList(viewModel)),
        ],
      ),
    );
  }

  
  Widget _buildSortRow(appColor, DoctorViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
          ..._sortOptions.map((sort) => _buildSortButton(sort, appColor, viewModel)),
        ],
      ),
    );
  }

  Widget _buildSortButton(Map<String, String> sort, appColor, DoctorViewModel viewModel) {
    final id = sort["id"]!;
    bool isSelected = false;

    switch (id) {
      case "az": isSelected = viewModel.activeSort == "name"; break;
      case "rating": isSelected = viewModel.activeSort == "rating"; break;
      case "favorite": isSelected = viewModel.showFavoriteOnly; break;
      case "male": isSelected = viewModel.activeGenderFilter == "Male"; break;
      case "female": isSelected = viewModel.activeGenderFilter == "Female"; break;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: GestureDetector(
        onTap: () {
          switch (id) {
            case "az": viewModel.toggleAlphabeticalSort(); break;
            case "rating": viewModel.toggleRatingSort(); break;
            case "favorite": viewModel.toggleFavoriteFilter(); break;
            case "male": viewModel.setGenderFilter("Male"); break;
            case "female": viewModel.setGenderFilter("Female"); break;
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
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))]
                : [],
          ),
          child: SvgPicture.asset(
            sort["icon"]!,
            color: isSelected ? appColor.white : appColor.Primary,
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorList(DoctorViewModel viewModel) {
    if (viewModel.isLoading) return const Center(child: CircularProgressIndicator());
    if (viewModel.errorMessage.isNotEmpty) return Center(child: Text(viewModel.errorMessage));
    if (viewModel.doctors.isEmpty) return const Center(child: Text("No doctors found."));

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: viewModel.doctors.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final docData = viewModel.doctors[index];
        
        // ⚠️ ARCHITECTURE WARNING: This mapping should ideally happen in your Repository/ViewModel!
        // viewModel.doctors should expose List<DoctorInfo>, not raw Maps.
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

        // Define the actions ONCE (DRY Principle)
        void handleFavToggle() => viewModel.toggleFavoriteStatus(doc.id);
        void handleBookTap() => viewModel.moveToScheduleScreen(context, doc);

        Widget tile;
        if (viewModel.activeSort == "rating") {
          tile = DoctorRatingTile(
            doctorName: doc.name,
            speciality: doc.speciality,
            image: doc.imageUrl,
            isFavorite: doc.isFavorite,
            rating: doc.rating,
            onFavoriteTap: handleFavToggle,
            onBookTap: handleBookTap,
          );
        } else if (viewModel.showFavoriteOnly) {
          tile = FavoriteDoctorTile(
            doctorName: doc.name,
            speciality: doc.speciality,
            image: doc.imageUrl,
            isFavorite: doc.isFavorite,
            onFavoriteTap: handleFavToggle,
            onBookTap: handleBookTap,
          );
        } else {
          tile = DoctorTile(
            doctorName: doc.name,
            speciality: doc.speciality,
            image: doc.imageUrl,
            isFavorite: doc.isFavorite,
            onFavoriteTap: handleFavToggle,
            onBookTap: handleBookTap,
          );
        }

        return InkWell(
          onTap: () => viewModel.moveToDoctorDetail(context, doc),
          child: TileExpansion(child: tile),
        );
      },
    );
  }

  @override
  void dispose() {
    final viewModel = context.read<DoctorViewModel>();
    viewModel.setSearchQuery('');
    super.dispose();
  }
}
