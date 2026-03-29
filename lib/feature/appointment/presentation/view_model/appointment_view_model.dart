import 'package:flutter/material.dart';
import 'package:skin_firts/core/services/api_services.dart';
import 'package:skin_firts/feature/appointment/entity/appointment.dart';

class AppointmentViewModel extends ChangeNotifier {
  final ApiServices apiServices;

  List<Appointment> _upcomingAppointments = [];
  List<Appointment> _completedAppointments = [];
  List<Appointment> _cancelledAppointments = [];
  bool _isLoading = true;
  bool _isLoadingUpcoming = true;
  bool _isLoadingCompleted = false;
  bool _isLoadingCancelled = false;

  List<Appointment> get upcomingAppointments => _upcomingAppointments;
  List<Appointment> get completedAppointments => _completedAppointments;
  List<Appointment> get cancelledAppointments => _cancelledAppointments;
  bool get isLoadingUpcoming => _isLoadingUpcoming;
  bool get isLoadingCompleted => _isLoadingCompleted;
  bool get isLoadingCancelled => _isLoadingCancelled;
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
    required String date,
    required String time,
    required Map<String, dynamic> patientDetails,
    // required BuildContext context,
  }) async {
    _isBooking = true;
    notifyListeners();

    try {
      final data = {
        'doctorId': doctorId,
        'appointmentDate': date,
        'appointmentTime': time,
        'patientDetails': patientDetails,
      };

      final response = await apiServices.bookAppointment(data);

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        return true;
      } else {
        debugPrint(
          "Error VM2 booking appointment. Status: ${response?.statusCode}. Msg: ${response?.data}",
        );
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

  Future<void> fetchAppointmentsByStatus(String status) async {
    _setLoading(status, true);
    try {
      final response = await apiServices.getAppointments(status);
      if (response != null && response.statusCode == 200) {
        final List<dynamic> responseData = response.data ?? [];
        final appointments =
            responseData.map((data) => Appointment.fromJson(data)).toList();
        _setAppointments(status, appointments);
      } else {
        _setAppointments(status, []);
      }
    } catch (e) {
      debugPrint("Error fetching $status appointments: $e");
      _setAppointments(status, []);
    } finally {
      _setLoading(status, false);
    }
  }

  void _setLoading(String status, bool isLoading) {
    if (status == 'upcoming') _isLoadingUpcoming = isLoading;
    if (status == 'completed') _isLoadingCompleted = isLoading;
    if (status == 'cancelled') _isLoadingCancelled = isLoading;
    notifyListeners();
  }

  void _setAppointments(String status, List<Appointment> appointments) {
    if (status == 'upcoming') _upcomingAppointments = appointments;
    if (status == 'completed') _completedAppointments = appointments;
    if (status == 'cancelled') _cancelledAppointments = appointments;
  }

  Future<void> fetchUpcomingAppointments() async {
    _isLoading = true;
    _isLoadingUpcoming = true;
    notifyListeners();

    try {
      final response = await apiServices.getAppointments('upcoming');

      if (response != null && response.statusCode == 200) {
        final List<dynamic> responseData = response.data ?? [];
        _upcomingAppointments =
            responseData.map((data) => Appointment.fromJson(data)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching upcoming appointments: $e");
    } finally {
      _isLoading = false;
      _isLoadingUpcoming = false;
      notifyListeners();
    }
  }

  dynamic get nextAppointment {
    if (_upcomingAppointments.isEmpty) return null;
    return _upcomingAppointments.first;
  }

  Future<bool> cancelAppointment({
    required String appointmentId,
    String reason = "No Reason Provided",
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await apiServices.cancelAppointment(
        appointmentId,
        reason,
      );

      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        final index = _upcomingAppointments.indexWhere(
          (appt) => appt.id == appointmentId,
        );
        if (index != -1) {
          final appointmentToCancel = _upcomingAppointments.removeAt(index);
          _cancelledAppointments.insert(
            0,
            appointmentToCancel.copyWith(status: AppointmentStatus.cancelled),
          );
        }
        return true;
      } else {
        debugPrint(
          "Failed to cancel appointment on server: ${response?.statusCode}",
        );
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
