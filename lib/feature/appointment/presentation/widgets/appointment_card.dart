import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/feature/appointment/presentation/pages/add_review.dart';
import 'package:skin_firts/feature/appointment/presentation/pages/cancel.dart';
import 'package:skin_firts/feature/appointment/presentation/pages/appointment_details_screen.dart';
import 'package:skin_firts/feature/Schedule/presentation/pages/schedule_screen.dart';

import '../../../../feature/doctor_pages/presentation/view_model/doctor_view_model.dart';
import '../../../../core/theme/color_palette.dart';
import '../../entity/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFD6E0FF).withOpacity(0.5), // Light blueish-purple
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 2), // White border
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(appointment.image),
              ),
              const SizedBox(width: 15),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: LightColorPalette.primary,
                        fontFamily: "LeagueSpartan",
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment.specialty,
                      style: const TextStyle(
                        fontSize: 13,
                        color: LightColorPalette.black,
                        fontFamily: "LeagueSpartan",
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Logic to show Rating (Complete) or nothing (Upcoming/Cancelled)
                    if (appointment.status == AppointmentStatus.completed)
                      Row(
                        children: [
                          _buildRatingPill(appointment.rating),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.favorite,
                            color: LightColorPalette.primary,
                            size: 20,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // --- DYNAMIC CONTENT BASED ON STATUS ---
          if (appointment.status == AppointmentStatus.upcoming)
            _buildUpcomingContent(context),
          if (appointment.status == AppointmentStatus.completed)
            _buildCompleteContent(context),
          if (appointment.status == AppointmentStatus.cancelled)
            _buildCancelledContent(context),
        ],
      ),
    );
  }

  // Content for "Upcoming" (Date chips + Details button)
  Widget _buildUpcomingContent(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildInfoChip(Icons.calendar_today, appointment.date),
            const SizedBox(width: 10),
            _buildInfoChip(Icons.access_time, appointment.time),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _buildButton("Details", true, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            AppointmentDetailsScreen(appointment: appointment),
                  ),
                );
              }),
            ),
            const SizedBox(width: 10),
            // _buildCircleButton(
            //   Icons.check,
            //   LightColorPalette.primary,
            // ), // Reschedule/Confirm
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CancelAppointmentScreen(
                          appointmentId: appointment.id,
                        ),
                  ),
                );
              },
              child: _buildCircleButton(Icons.close, LightColorPalette.primary),
            ), // Cancel
          ],
        ),
      ],
    );
  }

  // Content for "Complete" (Re-Book + Review)
  Widget _buildCompleteContent(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildButton("Re-Book", false, () {
            final doctorViewModel = context.read<DoctorViewModel>();
            final allDocs = [
              ...doctorViewModel.doctors,
              ...doctorViewModel.homeDoctors,
            ];

            dynamic foundDoctor;
            for (var doc in allDocs) {
              if ((doc['_id'] ?? doc['id']) == appointment.doctorId) {
                foundDoctor = doc;
                break;
              }
            }

            final List<dynamic> doctorAvailability =
                (foundDoctor != null && foundDoctor['availability'] != null)
                    ? foundDoctor['availability']
                    : [];

            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ScheduleScreen(
                      doctorId: appointment.doctorId,
                      doctorName: appointment.name,
                      availability: doctorAvailability,
                      image: appointment.image,
                      speciality: appointment.specialty,
                      isFavorite:
                          foundDoctor != null
                              ? (foundDoctor['isFavorite'] ?? false)
                              : false,
                      rating: appointment.rating,
                      review:
                          foundDoctor != null
                              ? (foundDoctor['reviews'] ?? 0)
                              : 0,
                    ),
              ),
            );
          }), // Outlined
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildButton("Add Review", true, () async {
            final reviewSubmitted = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ReviewScreen(
                      doctorId: appointment.doctorId,
                      doctorName: appointment.name,
                      doctorSpeciality: appointment.specialty,
                      image: appointment.image,
                    ),
              ),
            );

            // If a review was submitted, refresh the doctor list
            if (reviewSubmitted == true && context.mounted) {
              // Assuming DoctorViewModel is available via Provider
              context.read<DoctorViewModel>().fetchHomeDoctors();
            }
          }), // Filled
        ),
      ],
    );
  }

  // Content for "Cancelled" (Add Review)
  Widget _buildCancelledContent(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: _buildButton("Add Review", true, () async {
        final reviewSubmitted = await Navigator.push<bool>(
          context,
          MaterialPageRoute(
            builder:
                (context) => ReviewScreen(
                  doctorId: appointment.doctorId,
                  doctorName: appointment.name,
                  doctorSpeciality: appointment.specialty,
                  image: appointment.image,
                ),
          ),
        );

        // If a review was submitted, refresh the doctor list
        if (reviewSubmitted == true && context.mounted) {
          // Assuming DoctorViewModel is available via Provider
          context.read<DoctorViewModel>().fetchHomeDoctors();
        }
      }),
    );
  }

  // --- UI HELPERS ---

  Widget _buildRatingPill(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: LightColorPalette.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: LightColorPalette.primary, size: 14),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: const TextStyle(
              color: LightColorPalette.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: LightColorPalette.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: LightColorPalette.primary),
            const SizedBox(width: 5),
            Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                color: LightColorPalette.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, bool isFilled, VoidCallback onTap) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isFilled ? LightColorPalette.primary : LightColorPalette.white,
          foregroundColor:
              isFilled ? LightColorPalette.white : LightColorPalette.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side:
                isFilled
                    ? BorderSide.none
                    : const BorderSide(color: LightColorPalette.primary),
          ),
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
