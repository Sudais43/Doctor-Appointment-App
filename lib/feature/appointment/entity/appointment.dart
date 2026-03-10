

enum AppointmentStatus { complete, upcoming, cancelled }

class Appointment {
  final String name;
  final String specialty;
  final String image;
  final AppointmentStatus status;
  final double rating; // For Completed
  final String date;   // For Upcoming
  final String time;   // For Upcoming

  Appointment({
    required this.name,
    required this.specialty,
    required this.image,
    required this.status,
    this.rating = 0.0,
    this.date = '',
    this.time = '',
  });
}