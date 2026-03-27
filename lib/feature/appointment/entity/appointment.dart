import 'package:intl/intl.dart';

enum AppointmentStatus { completed, upcoming, cancelled }

class Appointment {
  final String id;
  final String doctorId;
  final String name;
  final String specialty;
  final String image;
  final AppointmentStatus status;
  final double rating; // For Completed
  final String date; // For Upcoming
  final String time; // For Upcoming

  Appointment({
    required this.id,
    required this.doctorId,
    required this.name,
    required this.specialty,
    required this.image,
    required this.status,
    this.rating = 0.0,
    this.date = '',
    this.time = '',
  });

  Appointment copyWith({
    String? id,
    String? doctorId,
    String? name,
    String? specialty,
    String? image,
    AppointmentStatus? status,
    double? rating,
    String? date,
    String? time,
  }) => Appointment(
    id: id ?? this.id,
    doctorId: doctorId ?? this.doctorId,
    name: name ?? this.name,
    specialty: specialty ?? this.specialty,
    image: image ?? this.image,
    status: status ?? this.status,
    rating: rating ?? this.rating,
    date: date ?? this.date,
    time: time ?? this.time,
  );

  factory Appointment.fromJson(Map<String, dynamic> json) {
    AppointmentStatus status;
    switch (json["status"]) {
      case "completed":
        status = AppointmentStatus.completed;
        break;
      case "upcoming":
        status = AppointmentStatus.upcoming;
        break;
      case "cancelled":
        status = AppointmentStatus.cancelled;
        break;
      default:
        status = AppointmentStatus.upcoming; // Default status if not recognized
    }
    final doctorData = json["doctorId"] as Map<String, dynamic>? ?? {};
    String formattedDate = '';
    if(json["date"] != null){
      DateTime parsedDate = DateTime.parse(json["date"]);
      formattedDate = DateFormat('EEEE, d MMMM').format(parsedDate);
    }
    return Appointment(
      id: json["_id"] ?? '',
      doctorId: doctorData["_id"] ?? '',
      name: doctorData["name"] ?? 'unKnown',
      specialty: doctorData["specialization"] as String? ?? '',
      image: doctorData["imageUrl"] as String? ?? '',
      status: status,
      rating: (doctorData["rating"] as num?)?.toDouble() ?? 0.0,
      date: formattedDate,
      time: json["timeSlot"] as String? ?? '',
    );
  }
}
