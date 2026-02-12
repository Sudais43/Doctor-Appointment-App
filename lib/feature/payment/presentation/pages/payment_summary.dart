import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/color_palette.dart';

// --- Constants for Colors (Replace with your LightColorPalette) ---
class AppColors {
  static const Color primary = Color(0xFF2962FF); // The main Blue
  static const Color white = Colors.white;
  static const Color textDark = Color(0xFF263238);
  static const Color textLightBlue = Color(0xFF8FA1D0); // The label color
  static const Color chipBackground = Color(0xFFC5CEE0); // Light purple/blue for chips
  static const Color divider = Color(0xFFEFF3FF);
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Background for the top part
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "LeagueSpartan",
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          // --- TOP SECTION: PRICE ---
          const SizedBox(height: 20),
          const Text(
            "\$ 100.00",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: "LeagueSpartan",
            ),
          ),
          const SizedBox(height: 40),

          // --- BOTTOM SECTION: WHITE CARD ---
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 1. Doctor Profile
                    _buildDoctorProfile(),

                    const SizedBox(height: 20),
                    const Divider(color: LightColorPalette.secondary, thickness: 1.5),
                    const SizedBox(height: 20),

                    // 2. Booking Details
                    _buildDetailRow("Date / Hour", "Month 24, Year / 10:00 AM"),
                    const SizedBox(height: 15),
                    _buildDetailRow("Duration", "30 Minutes"),
                    const SizedBox(height: 15),
                    _buildDetailRow("Booking for", "Another Person"),

                    const SizedBox(height: 20),
                    const Divider(color: LightColorPalette.secondary, thickness: 1.5),
                    const SizedBox(height: 20),

                    // 3. Cost Breakdown
                    _buildDetailRow("Amount", "\$100.00"),
                    const SizedBox(height: 15),
                    _buildDetailRow("Duration", "30 Minutes"),
                    const SizedBox(height: 20),

                    // Total Row (Slightly different styling)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Total",
                          style: TextStyle(
                            color: AppColors.textLightBlue,
                            fontSize: 16,
                            fontFamily: "LeagueSpartan",
                          ),
                        ),
                        Text(
                          "\$100",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "LeagueSpartan",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Divider(color: LightColorPalette.secondary, thickness: 1.5),
                    const SizedBox(height: 20),

                    // 4. Payment Method
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Payment Method",
                          style: TextStyle(
                            color: AppColors.textLightBlue,
                            fontSize: 15,
                            fontFamily: "LeagueSpartan",
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Card",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "LeagueSpartan",
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {}, // Add change logic
                              child: const Text(
                                "Change",
                                style: TextStyle(
                                  color: AppColors.primary, // Blue link color
                                  fontSize: 14,
                                  fontFamily: "LeagueSpartan",
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 40),

                    // 5. Pay Now Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Pay Now",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "LeagueSpartan",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget 1: Doctor Profile ---
  Widget _buildDoctorProfile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        const CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage("assets/icons/Doctors/images/doctor1.png"),
          // Use NetworkImage for URL: NetworkImage('https://via.placeholder.com/150')
        ),
        const SizedBox(width: 15),

        // Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      "Dr. Olivia Turner, M.D.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontFamily: "LeagueSpartan",
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.verified, color: AppColors.primary, size: 24),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Dermato-Endocrinology",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontFamily: "LeagueSpartan",
                ),
              ),
              const SizedBox(height: 10),

              // Chips Row
              Row(
                children: [
                  _buildChip(Icons.star, "5"),
                  const SizedBox(width: 10),
                  _buildChip(Icons.chat_bubble_outline, "60"),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  // --- Helper Widget 2: Small Chips (Rating/Chat) ---
  Widget _buildChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFC5CEE0).withOpacity(0.5), // Light purple/blue bg
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget 3: Reusable Label-Value Row ---
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: LightColorPalette.textColor,
            fontSize: 15,
            fontFamily: "LeagueSpartan",
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: LightColorPalette.black,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: "LeagueSpartan",
          ),
        ),
      ],
    );
  }
}