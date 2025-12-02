import 'package:flutter/material.dart';

// --- Constants for Colors ---
class AppColors {
  // Matches the vibrant blue background
  static const Color primary = Color(0xFF2962FF);
  static const Color white = Colors.white;
}

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent to show blue bg
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1), // Pushes content down slightly

              // --- 1. SUCCESS CHECKMARK ---
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 8), // Thick white ring
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_rounded,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // --- 2. MAIN TEXT ---
              const Text(
                "Congratulation",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "LeagueSpartan",
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Payment is Successfully", // Text as per design
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: "LeagueSpartan",
                ),
              ),

              const Spacer(flex: 1),

              // --- 3. APPOINTMENT DETAILS CARD ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1), // Subtle transparent fill
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                ),
                child: Column(
                  children: [
                    const Text(
                      "You have successfully booked an appointment with",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontFamily: "LeagueSpartan",
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Doctor Name
                    const Text(
                      "Dr. Olivia Turner, M.D.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "LeagueSpartan",
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Date & Time Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Date
                        _buildIconText(Icons.calendar_today_outlined, "Month 24, Year"),

                        const SizedBox(width: 25), // Spacing between items

                        // Time
                        _buildIconText(Icons.access_time, "10:00 AM"),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2), // More space at the bottom for balance
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widget for Icon + Text ---
  Widget _buildIconText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: "LeagueSpartan",
          ),
        ),
      ],
    );
  }
}