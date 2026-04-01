import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/feature/appointment/presentation/pages/cancel.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';
import 'package:skin_firts/feature/appointment/entity/appointment.dart';

class UpcomingAppointmentWidget extends StatelessWidget {
  const UpcomingAppointmentWidget({super.key});

  // Reusable text style for the times on the left axis
  final TextStyle _timeAxisStyle = const TextStyle(
    color: Color(0xFF4B7BEE),
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: "LeagueSpartan",
  );

  @override
  Widget build(BuildContext context) {
    final appointmentVM = context.watch<AppointmentViewModel>();
    final Appointment? appointment = appointmentVM.nextAppointment;

    if (appointment == null) {
      return _buildEmptyState();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Top Right Date Text (e.g., "11 Wednesday - Today")
          Text(
            appointment.date, // Replace with formatted date if needed
            style: const TextStyle(
              color: Color(0xFF2D63E2),
              fontWeight: FontWeight.w500,
              fontSize: 12,
              fontFamily: "LeagueSpartan",
            ),
          ),
          const SizedBox(height: 5),

          // --- THE TWO-LINE TIMELINE LAYOUT ---
          SizedBox(
            height: 120, // Fixed height perfectly distributes the space
            child: Row(
              children: [
                // LEFT COLUMN: The Time Labels
                SizedBox(
                  width: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("9 AM", style: _timeAxisStyle),
                      Text("10 AM", style: _timeAxisStyle),
                      Text("11 AM", style: _timeAxisStyle),
                      Text("12 PM", style: _timeAxisStyle),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // RIGHT COLUMN: Top Line, Blue Card, Bottom Line
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Dotted Line (Aligned with 9 AM)
                      const SizedBox(
                        height: 14, // Matches the height of the 12pt text
                        child: Center(child: DottedDivider()),
                      ),

                      // The Blue Card (Expands to fill the space between lines)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                          ), // Breathing room
                          child: _AppointmentCard(appointment: appointment),
                        ),
                      ),

                      // Bottom Dotted Line (Aligned with 12 PM)
                      const SizedBox(
                        height: 14, // Matches the height of the 12pt text
                        child: Center(child: DottedDivider()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "No upcoming appointments",
            style: TextStyle(
              color: Color(0xFF4A4A4A),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// INNER BLUE CARD COMPONENT
// ==========================================
class _AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFC7D6FA), // Light blue from the design
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centers text vertically
              children: [
                Text(
                  appointment.name,
                  style: const TextStyle(
                    color: Color(0xFF2D63E2),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: "LeagueSpartan",
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  appointment.specialty, // Or 'problem' depending on your data
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 12,
                    height: 1.3,
                    fontFamily: "LeagueSpartan",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Action Icons
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(Icons.check, const Color(0xFF2D63E2)),
              const SizedBox(width: 6),
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
                child: _buildIcon(Icons.close, const Color(0xFF2D63E2)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 14, color: color),
    );
  }
}

// ==========================================
// DOTTED DIVIDER COMPONENT
// ==========================================
class DottedDivider extends StatelessWidget {
  const DottedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 3.0;
        const dashHeight = 1.5;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();

        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFF8BA6F5)),
              ),
            );
          }),
        );
      },
    );
  }
}
