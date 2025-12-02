import '../entity/appointment.dart';

final List<Appointment> allAppointments = [
  Appointment(
    name: "Dr. Olivia Turner, M.D.",
    specialty: "Dermato-Endocrinology",
    image: "assets/icons/Doctors/images/doctor1.png",
    status: AppointmentStatus.complete,
    rating: 5.0,
  ),
  Appointment(
    name: "Dr. Alexander Bennett, Ph.D.",
    specialty: "Dermato-Genetics",
    image: "assets/icons/Doctors/images/doctor1.png",
    status: AppointmentStatus.complete,
    rating: 4.0,
  ),
  Appointment(
    name: "Dr. Sophia Martinez, Ph.D.",
    specialty: "Cosmetic Bioengineering",
    image: "assets/icons/Doctors/images/doctor1.png",
    status: AppointmentStatus.upcoming,
    date: "Sunday, 12 June",
    time: "9:30 AM - 10:00 AM",
  ),
  Appointment(
    name: "Dr. Alexander Bennett, Ph.D.",
    specialty: "Dermato-Genetics",
    image: "assets/icons/Doctors/images/doctor1.png",
    status: AppointmentStatus.upcoming,
    date: "Friday, 20 June",
    time: "2:30 PM - 3:00 PM",
  ),
  Appointment(
    name: "Dr. Olivia Turner, M.D.",
    specialty: "Dermato-Endocrinology",
    image: "assets/icons/Doctors/images/doctor1.png",
    status: AppointmentStatus.cancelled,
  ),
];