import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skin_firts/core/services/api_services.dart';
import 'package:skin_firts/feature/appointment/entity/appointment.dart';
import 'package:skin_firts/feature/appointment/entity/calender_day.dart';

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
  AppointmentStatus _selectedStatus = AppointmentStatus.upcoming;
  AppointmentStatus get selectedStatus => _selectedStatus;

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
    String?
    paymentIntentId, // ADD THIS: Pass the Stripe payment ID if your backend requires it
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
        if (paymentIntentId != null)
          'paymentIntentId': paymentIntentId, // ADD THIS
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

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
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

  List<CalendarDay> getCalendarDays() {
    final now = DateTime.now();

    // 1. Get formatted appointment dates
    final appointmentDates =
        upcomingAppointments
            .map((app) {
              if (app.date.isNotEmpty) {
                final parsedDate = DateTime.tryParse(app.date);
                if (parsedDate != null) {
                  return DateFormat('yyyy-MM-dd').format(parsedDate.toLocal());
                }
                final match = RegExp(r'\d+').firstMatch(app.date);
                if (match != null) return match.group(0);
              }
              return null;
            })
            .where((day) => day != null)
            .toSet();

    // 2. Generate the next 6 days and check for matches
    return List.generate(6, (index) {
      final date = now.add(Duration(days: index));
      final fullDate = DateFormat('yyyy-MM-dd').format(date);
      final dayStr = date.day.toString();

      final hasAppt =
          appointmentDates.contains(fullDate) ||
          appointmentDates.contains(dayStr);

      return CalendarDay(
        day: dayStr,
        label: DateFormat('E').format(date).toUpperCase(),
        fullDate: fullDate,
        hasAppointment: hasAppt,
      );
    });
  }

 

  // 1. Hold the state of the active tab


  // 2. Automatically give the UI the correct list based on the active tab
  List<Appointment> get currentDisplayedList {
    switch (_selectedStatus) {
      case AppointmentStatus.upcoming: return upcomingAppointments;
      case AppointmentStatus.completed: return completedAppointments;
      case AppointmentStatus.cancelled: return cancelledAppointments;
    }
  }

  // 3. Automatically give the UI the correct loading state
  bool get isCurrentListLoading {
    switch (_selectedStatus) {
      case AppointmentStatus.upcoming: return isLoadingUpcoming;
      case AppointmentStatus.completed: return isLoadingCompleted;
      case AppointmentStatus.cancelled: return isLoadingCancelled;
    }
  }

  // 4. Handle the tab change AND the data fetching logic
  void changeTab(AppointmentStatus newStatus) {
    if (_selectedStatus == newStatus) return; 

    _selectedStatus = newStatus;
    notifyListeners(); // Update the UI tab colors instantly

    // Decide if we need to fetch data
    if (newStatus == AppointmentStatus.completed && completedAppointments.isEmpty) {
      fetchAppointmentsByStatus('completed');
    } else if (newStatus == AppointmentStatus.cancelled && cancelledAppointments.isEmpty) {
      fetchAppointmentsByStatus('cancelled');
    } else if (newStatus == AppointmentStatus.upcoming && upcomingAppointments.isEmpty) {
      fetchAppointmentsByStatus('upcoming');
    }
  }

  // 5. Keep navigation in the ViewModel
  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  // 1. The list of reasons belongs in the ViewModel (it's business data)
  final List<String> cancellationReasons = [
    "Rescheduling",
    "Weather Conditions",
    "Unexpected Work",
    "Others",
  ];

  // 2. State for the screen
  int _selectedCancelReasonIndex = 1;
  int get selectedCancelReasonIndex => _selectedCancelReasonIndex;

  bool _isCancellingAppointment = false;
  bool get isCancellingAppointment => _isCancellingAppointment;

  // 3. Action to update the radio button
  void setCancelReasonIndex(int index) {
    _selectedCancelReasonIndex = index;
    notifyListeners();
  }

  // 4. Action to handle the whole cancellation process
  Future<void> processCancellation({
    required BuildContext context,
    required String appointmentId,
    required String customReasonText,
  }) async {
    
    // Validate the input
    String finalReason = cancellationReasons[_selectedCancelReasonIndex];
    if (_selectedCancelReasonIndex == 3) { // "Others"
      if (customReasonText.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter a reason when selecting 'Others'."),
            backgroundColor: Colors.red,
          ),
        );
        return; // Stop processing
      }
      finalReason = customReasonText.trim();
    }

    // Start loading
    _isCancellingAppointment = true;
    notifyListeners();

    // Call the actual API (assuming you already have this method)
    final success = await cancelAppointment(appointmentId: appointmentId, reason: finalReason);

    // Stop loading
    _isCancellingAppointment = false;
    notifyListeners();

    if (!context.mounted) return;

    // Handle the result
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Appointment cancelled successfully."), backgroundColor: Colors.green),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to cancel appointment. Please try again."), backgroundColor: Colors.red),
      );
    }
  }

  // Reset state when entering the screen
  void resetCancelState() {
    _selectedCancelReasonIndex = 1;
    _isCancellingAppointment = false;
  }

}
