import 'package:flutter/material.dart';
import 'package:skin_firts/core/services/api_services.dart';

class AppointmentViewModel extends ChangeNotifier {
  final ApiServices apiServices;

  List<dynamic> _upcomingAppointments = [];
  bool _isLoading = true;

  List<dynamic> get upcomingAppointments => _upcomingAppointments;
  bool get isLoading => _isLoading;

  AppointmentViewModel({required this.apiServices}) {
    fetchUpcomingAppointments();
  }

  DateTime _selectedDate = DateTime.now();
  List<dynamic> _availableSlot = [];
  String _selectedTimeSlot = "";
  String PatientType = "Yourself";
  String _selectedGender = "";
  bool _isBooking = false;

  List<dynamic> get availableSlots => _availableSlot;
  DateTime get selectedDate => _selectedDate;
  String get selectedTimeSlot => _selectedTimeSlot;
  String get patientType => PatientType;
  String get selectedGender => _selectedGender;
  bool get isBooking => _isBooking;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    _selectedTimeSlot = ""; // Reset selection
    notifyListeners();
  }

  void setSelectedTimeSlot(String timeSlot) {
    _selectedTimeSlot = timeSlot;
    notifyListeners();
  }

  void setPatientType(String type) {
    PatientType = type;
    notifyListeners();
  }

  void setSelectedGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  void setBooking(bool booking) {
    _isBooking = booking;
    notifyListeners();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Future<void> fetchAvailableSlots(String doctorId, DateTime date) async {
    _availableSlot = [];
    setBooking(true);
    notifyListeners();

    final String dateString =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    try {
      final response = await apiServices.getDoctorAvailability(
        doctorId,
        dateString,
      );
      if (response != null && response.statusCode == 200) {
        _availableSlot = response.data ?? [];
      }
    } catch (e) {
      _availableSlot =
          []; // Clear slots on error to prevent showing stale data.
      debugPrint("Error fetching available slots: $e");
    } finally {
      setBooking(false);
      notifyListeners();
    }
  }

  Future<bool> bookAppointment({
    required String doctorId,
    required DateTime date,
    required String time,
    required Map<String, dynamic> patientDetails,
    // required BuildContext context,
  }) async {
    _isBooking = true;
    notifyListeners();

    try {
      final data = {
        'doctorId': doctorId,
        'appointmentDate': date.toIso8601String(),
        'appointmentTime': time,
        'patientDetails': patientDetails,
      };
      
      final response = await apiServices.bookAppointment(data);

      if(response != null && (response.statusCode == 200|| response.statusCode == 201)){
        return true;
      }else{
        debugPrint("Error VM2 booking appointment. Status: ${response?.statusCode}. Msg: ${response?.data}");
        return false;
      }

    } catch (e) {
      debugPrint("Error VM booking appointment: $e");
      return false;
    } finally {
      _isBooking = false;
      notifyListeners();
    }
  }

  Future<void> fetchUpcomingAppointments() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await apiServices.getAppointments('upcoming');

      if (response != null && response.statusCode == 200) {
        _upcomingAppointments = response.data;
      }
    } catch (e) {
      debugPrint("Error fetching upcoming appointments: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  dynamic get nextAppointment {
    if (_upcomingAppointments.isEmpty) return null;
    return _upcomingAppointments.first;
  }
}
