import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:skin_firts/core/navigation/page_transition.dart';
import 'package:skin_firts/core/services/api_services.dart';
import 'package:skin_firts/core/widget/custom_snackbar.dart';
import 'package:skin_firts/feature/Schedule/presentation/pages/schedule_screen.dart';
import 'package:skin_firts/feature/appointment/entity/review.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/pages/doctor_detail.dart';
import 'package:skin_firts/feature/homePage/domain/entities/doctor_info.dart';

class DoctorViewModel extends ChangeNotifier {
  final ApiServices apiServices;
  List<dynamic> _doctors = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<dynamic> _homeDoctors = [];
  bool _isHomeLoading = true;

  final Map<String, bool> _localFavoriteStates = {};

  String _activeSort = "";
  String _activeGenderFilter = "";
  String _activeSpecializationFilter = "";
  bool _showFavoriteOnly = false;
  String _searchQuery = "";

  List<dynamic> get doctors {
    if (_searchQuery.isEmpty) {
      return _doctors;
    }
    return _doctors.where((doctor) {
      final name = (doctor['name'] as String? ?? '').toLowerCase();
      final specialization =
          (doctor['specialization'] as String? ?? '').toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || specialization.contains(query);
    }).toList();
  }
  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage ?? "";

  List<dynamic> get homeDoctors => _homeDoctors;
  bool get isHomeLoading => _isHomeLoading;

  String get activeSort => _activeSort;
  String get activeGenderFilter => _activeGenderFilter;
  bool get showFavoriteOnly => _showFavoriteOnly;
  String get activeSpecializationFilter => _activeSpecializationFilter;

  List<DoctorReview> _doctorReviews = [];
  List<DoctorReview> get doctorReviews => _doctorReviews;
  bool _isReviewsLoading = false;
  bool get isReviewsLoading => _isReviewsLoading;

  DoctorViewModel({required this.apiServices}) {
    _loadLocalFavorites();
    fetchHomeDoctors();
    fetchDoctor();
  }

  void _loadLocalFavorites() {
    try {
      if (Hive.isBoxOpen('current_session')) {
        final sessionBox = Hive.box('current_session');
        final List<dynamic>? storedFavs = sessionBox.get('favorites');
        if (storedFavs != null) {
          for (var id in storedFavs) {
            _localFavoriteStates[id.toString()] = true;
          }
        }
      }
    } catch (e) {
      debugPrint("Error loading favorites from Hive: $e");
    }
  }

  void _saveLocalFavorites() {
    try {
      if (Hive.isBoxOpen('current_session')) {
        final sessionBox = Hive.box('current_session');
        final favList =
            _localFavoriteStates.entries
                .where((e) => e.value == true)
                .map((e) => e.key)
                .toList();
        sessionBox.put('favorites', favList);
      }
    } catch (e) {
      debugPrint("Error saving favorites to Hive: $e");
    }
  }

  String? _expandedDoctorName;
  String? get expandedDoctorName => _expandedDoctorName;

  Future<void> fetchHomeDoctors() async {
    _isHomeLoading = true;
    notifyListeners();

    try {
      final response = await apiServices.getDoctor();

      if (response != null && response.statusCode == 200) {
        List<dynamic> fetchedDoctors = response.data;

        // Apply any local favorite overrides so they aren't lost on refresh
        for (var i = 0; i < fetchedDoctors.length; i++) {
          final docId =
              fetchedDoctors[i]['_id'] ?? fetchedDoctors[i]['id'] ?? '';

          if (fetchedDoctors[i]['isFavorite'] == true) {
            _localFavoriteStates[docId] = true;
          }

          if (_localFavoriteStates.containsKey(docId)) {
            fetchedDoctors[i]['isFavorite'] = _localFavoriteStates[docId];
          }
        }

        _homeDoctors = fetchedDoctors;
      } else {
        _homeDoctors = [];
      }
    } catch (e) {
      debugPrint("ViewModel Error fetching home doctors: $e");
      _homeDoctors = [];
    } finally {
      _isHomeLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDoctor() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiServices.getDoctor(
        sort: _activeSort.isNotEmpty ? _activeSort : null,
        gender: _activeGenderFilter.isNotEmpty ? _activeGenderFilter : null,
        specialization: _activeSpecializationFilter.isNotEmpty
            ? _activeSpecializationFilter
            : null,
      );

      if (response != null && response.statusCode == 200) {
        List<dynamic> fetchedDoctors = response.data;

        // Apply any local favorite overrides so they aren't lost on refresh
        for (var i = 0; i < fetchedDoctors.length; i++) {
          final docId =
              fetchedDoctors[i]['_id'] ?? fetchedDoctors[i]['id'] ?? '';

          if (fetchedDoctors[i]['isFavorite'] == true) {
            _localFavoriteStates[docId] = true;
          }

          if (_localFavoriteStates.containsKey(docId)) {
            fetchedDoctors[i]['isFavorite'] = _localFavoriteStates[docId];
          }
        }

        _doctors = fetchedDoctors;

        if (_showFavoriteOnly) {
          _doctors =
              _doctors.where((doctor) => doctor['isFavorite'] == true).toList();
        }
      } else {
        _errorMessage = "Failed to load doctor";
        _doctors = [];
      }
    } catch (e) {
      debugPrint("ViewModel Error fetching doctors: $e");
      _errorMessage = "Connection Error. Please try again";
      _doctors = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDoctorReviews(String doctorId) async {
    _isReviewsLoading = true;
    notifyListeners();
    try {
      final response = await apiServices.getReviews(doctorId);
      if (response != null && response.statusCode == 200) {
        final List<dynamic> fetchedReviews = response.data;
        _doctorReviews =
            fetchedReviews.map((json) => DoctorReview.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint("ViewModel Error fetching doctor reviews: $e");
    } finally {
      _isReviewsLoading = false;
      notifyListeners();
    }
  }

  Future<bool> submitReviews(
    String doctorId,
    double rating,
    String comment,
  ) async {
    try {
      final data = {'doctorId': doctorId, 'rating': rating, 'comment': comment};

      final response = await apiServices.submitReview(data);
      if (response != null &&
          (response.statusCode == 201 || response.statusCode == 200)) {
        await fetchDoctorReviews(doctorId);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("ViewModel Error submitting review: $e");
      return false;
    }
  }

  void _clearAllFilters() {
    _activeSort = "";
    _activeGenderFilter = "";
    _showFavoriteOnly = false;
  }

  void toggleAlphabeticalSort() {
    final wasActive = _activeSort == "name";
    _clearAllFilters();
    if (!wasActive) {
      _activeSort = "name";
    }
    fetchDoctor();
  }

  void toggleRatingSort() {
    final wasActive = _activeSort == "rating";
    _clearAllFilters();
    if (!wasActive) {
      _activeSort = "rating";
    }
    fetchDoctor();
  }

  void setGenderFilter(String gender) {
    final wasActive = _activeGenderFilter == gender;
    _clearAllFilters();
    if (!wasActive) {
      _activeGenderFilter = gender;
    }
    fetchDoctor();
  }

  void setSpecializationFilter(String specialization) {
    final wasActive = _activeSpecializationFilter == specialization;
    _clearAllFilters();
    if (!wasActive) {
      _activeSpecializationFilter = specialization;
    }
    fetchDoctor();
  }

  void toggleFavoriteFilter() {
    final wasActive = _showFavoriteOnly;
    _clearAllFilters();
    if (!wasActive) {
      _showFavoriteOnly = true;
    }
    fetchDoctor();
  }

  void setFavoriteFilter(bool showFavorite) {
    if (_showFavoriteOnly != showFavorite) {
      _showFavoriteOnly = showFavorite;
      fetchDoctor();
    }
  }

  void setFavoriteOnlyFilter() {
    _activeSort = "";
    _activeGenderFilter = "";
    _showFavoriteOnly = true;
    fetchDoctor();
  }

  Future<void> markAsFavorite(String doctorId, bool isFavorite) async {
    final index = _doctors.indexWhere((doc) => doc['id'] == doctorId);
    if (index != -1) {
      _doctors[index]['isFavorite'] = isFavorite;
      notifyListeners();
    }
  }

  void toggleExpansion(String doctorName) {
    if (_expandedDoctorName == doctorName) {
      _expandedDoctorName = null;
    } else {
      _expandedDoctorName = doctorName;
    }
    notifyListeners();
  }

  //Move To Doctor Detail page
  void moveToDoctorDetail(BuildContext context, DoctorInfo doc) {
    Navigator.push(
      context,
      FadeRoute(
        page: DoctorDetail(
          doctorId: doc.id,
          doctorName: doc.name,
          image: doc.imageUrl,
          speciality: doc.speciality,
          isFavorite: doc.isFavorite,
          availability: doc.availability,
          rating: doc.rating,
          reviews: doc.reviews,
        ),
      ),
    );
  }

  Future<void> toggleFavoriteStatus(String doctorId) async {
    final index = _doctors.indexWhere(
      (doc) => doc['_id'] == doctorId || doc['id'] == doctorId,
    );
    final homeIndex = _homeDoctors.indexWhere(
      (doc) => doc['_id'] == doctorId || doc['id'] == doctorId,
    );

    if (index == -1 && homeIndex == -1) return;

    bool currentStatuss = false;
    if (index != -1) {
      currentStatuss = _doctors[index]['isFavorite'] ?? false;
    } else if (homeIndex != -1) {
      currentStatuss = _homeDoctors[homeIndex]['isFavorite'] ?? false;
    }

    final bool newStatus = !currentStatuss;

    if (index != -1) _doctors[index]['isFavorite'] = newStatus;
    if (homeIndex != -1) _homeDoctors[homeIndex]['isFavorite'] = newStatus;

    _localFavoriteStates[doctorId] = newStatus;
    _saveLocalFavorites();
    notifyListeners();

    try {
      final response = await apiServices.toggleFavorite(doctorId);
      if (response == null || response.statusCode != 200) {
        if (index != -1) _doctors[index]['isFavorite'] = currentStatuss;
        if (homeIndex != -1) {
          _homeDoctors[homeIndex]['isFavorite'] = currentStatuss;
        }
        _localFavoriteStates[doctorId] = currentStatuss;
        _saveLocalFavorites();
        notifyListeners();
        debugPrint("Failed to update favorite on server. Reverting UI.");
      }
    } catch (e) {
      if (index != -1) _doctors[index]['isFavorite'] = currentStatuss;
      if (homeIndex != -1) {
        _homeDoctors[homeIndex]['isFavorite'] = currentStatuss;
      }
      _localFavoriteStates[doctorId] = currentStatuss;
      _saveLocalFavorites();
      notifyListeners();
    }
  }

  void moveToPreviousPage(BuildContext context) {
    Navigator.pop(context);
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Add this to DoctorViewModel
  void moveToScheduleScreen(BuildContext context, DoctorInfo doc) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduleScreen(
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
  }

  // --- ADD THIS TO DOCTOR VIEW MODEL ---

  // 1. State for the Review Screen
  
  int _currentRating = 3;
  int get currentRating => _currentRating;

  bool _isSubmittingReview = false;
  bool get isSubmittingReview => _isSubmittingReview;

  // 2. Action to update rating
  void setRating(int newRating) {
    _currentRating = newRating;
    notifyListeners();
  }

  // 3. Action to submit the review (handles validation and routing)
  Future<void> submitDoctorReview({
    required BuildContext context,
    required String doctorId,
    required String comment,
  }) async {
    if (comment.trim().isEmpty) {
      CustomSnackBar.show(
        context,
        message: "Please write a comment before submitting",
        isError: true,
      );
      return;
    }

    _isSubmittingReview = true;
    notifyListeners();

    // Call your repository/API here
    bool isSuccess = await submitReviews(doctorId, _currentRating.toDouble(), comment.trim());

    _isSubmittingReview = false;
    notifyListeners();

    if (!context.mounted) return;

    if (isSuccess) {
      CustomSnackBar.show(context, message: "Thank you for your review!", isError: false);
      Navigator.pop(context, true); // Go back and indicate success
    } else {
      CustomSnackBar.show(context, message: "Failed to submit review, please try again", isError: true);
    }
  }

  // Optional: Reset state when leaving the screen
  void resetReviewState() {
    _currentRating = 3;
    _isSubmittingReview = false;
  }
}
