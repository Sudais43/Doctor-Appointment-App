import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:skin_firts/core/navigation/page_transition.dart';
import 'package:skin_firts/core/services/api_services.dart';
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
  bool _showFavoriteOnly = false;

  List<dynamic> get doctors => _doctors;
  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage ?? "";

  List<dynamic> get homeDoctors => _homeDoctors;
  bool get isHomeLoading => _isHomeLoading;

  String get activeSort => _activeSort;
  String get activeGenderFilter => _activeGenderFilter;
  bool get showFavoriteOnly => _showFavoriteOnly;

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
        final favList = _localFavoriteStates.entries
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
        if (homeIndex != -1) _homeDoctors[homeIndex]['isFavorite'] = currentStatuss;
        _localFavoriteStates[doctorId] = currentStatuss;
        _saveLocalFavorites();
        notifyListeners();
        debugPrint("Failed to update favorite on server. Reverting UI.");
      }
    } catch (e) {
      if (index != -1) _doctors[index]['isFavorite'] = currentStatuss;
      if (homeIndex != -1) _homeDoctors[homeIndex]['isFavorite'] = currentStatuss;
      _localFavoriteStates[doctorId] = currentStatuss;
      _saveLocalFavorites();
      notifyListeners();
    }
  }

  void moveToPreviousPage(BuildContext context) {
    Navigator.pop(context);
  }
}
