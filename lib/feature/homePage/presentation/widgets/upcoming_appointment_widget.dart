import 'package:flutter/material.dart';

class UpcomingAppointmentWidget extends StatelessWidget {
  const UpcomingAppointmentWidget({super.key});

  // Reusable text style for the times
  final TextStyle _timeStyle = const TextStyle(
    color: Color(0xFF4B7BEE),
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Top Right Date Text
          const Text(
            "11 Wednesday - Today",
            style: TextStyle(
              color: Color(0xFF2D63E2),
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),

          // 9 AM Row (Time + Dotted Line)
          _buildTimeRow("9 AM"),
          const SizedBox(height: 12),

          // 10 AM & 11 AM + Blue Card Section
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Times Column
                SizedBox(
                  width: 45,
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceAround, // Aligns times to top & bottom of card
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("10 AM", style: _timeStyle),
                      Text("11 AM", style: _timeStyle),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // The Appointment Card
                const Expanded(child: _AppointmentCard()),
              ],
            ),
          ),

          const SizedBox(height: 12),
          // 12 AM Row (Time + Dotted Line)
          _buildTimeRow("12 AM"),
        ],
      ),
    );
  }

  // Helper to build a standard time row with a dotted line
  Widget _buildTimeRow(String time) {
    return Row(
      children: [
        SizedBox(width: 45, child: Text(time, style: _timeStyle)),
        const SizedBox(width: 8),
        const Expanded(child: DottedDivider()),
      ],
    );
  }
}

// ==========================================
// INNER BLUE CARD COMPONENT
// ==========================================
class _AppointmentCard extends StatelessWidget {
  const _AppointmentCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFCFDFFF), // Light blue background
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Dr. Olivia Turner, M.D.",
                  style: TextStyle(
                    color: Color(0xFF2D63E2),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Treatment and prevention of skin and photodermatitis.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF4A4A4A),
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Action Icons
          Row(
            children: [
              _buildIcon(Icons.check, const Color(0xFF2D63E2)),
              const SizedBox(width: 6),
              _buildIcon(Icons.close, const Color(0xFF2D63E2)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 14, color: color),
    );
  }
}

// ==========================================
// DOTTED DIVIDER COMPONENT (No external packages needed)
// ==========================================
class DottedDivider extends StatelessWidget {
  const DottedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 3.0;
        const dashHeight = 1.0;
        // Calculate how many dashes fit on the screen
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
