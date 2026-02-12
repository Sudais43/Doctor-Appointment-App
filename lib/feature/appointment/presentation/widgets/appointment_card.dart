import 'package:flutter/material.dart';

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
                    if (appointment.status == AppointmentStatus.complete)
                      Row(
                        children: [
                          _buildRatingPill(appointment.rating),
                          const SizedBox(width: 10),
                          const Icon(Icons.favorite, color: LightColorPalette.primary, size: 20),
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
            _buildUpcomingContent(),
          if (appointment.status == AppointmentStatus.complete)
            _buildCompleteContent(),
          if (appointment.status == AppointmentStatus.cancelled)
            _buildCancelledContent(),
        ],
      ),
    );
  }

  // Content for "Upcoming" (Date chips + Details button)
  Widget _buildUpcomingContent() {
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
              child: _buildButton("Details", true, () {}),
            ),
            const SizedBox(width: 10),
            _buildCircleButton(Icons.check, LightColorPalette.primary), // Reschedule/Confirm
            const SizedBox(width: 10),
            _buildCircleButton(Icons.close, LightColorPalette.primary), // Cancel
          ],
        )
      ],
    );
  }

  // Content for "Complete" (Re-Book + Review)
  Widget _buildCompleteContent() {
    return Row(
      children: [
        Expanded(
          child: _buildButton("Re-Book", false, () {}), // Outlined
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildButton("Add Review", true, () {}), // Filled
        ),
      ],
    );
  }

  // Content for "Cancelled" (Add Review)
  Widget _buildCancelledContent() {
    return SizedBox(
      width: double.infinity,
      child: _buildButton("Add Review", true, () {}),
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
          backgroundColor: isFilled ? LightColorPalette.primary : LightColorPalette.white,
          foregroundColor: isFilled ? LightColorPalette.white : LightColorPalette.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: isFilled ? BorderSide.none : const BorderSide(color: LightColorPalette.primary),
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
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}