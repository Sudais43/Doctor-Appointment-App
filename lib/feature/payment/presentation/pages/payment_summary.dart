import 'package:flutter/material.dart';
import 'package:skin_firts/core/services/stripe_services.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/feature/payment/presentation/pages/payment_method.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _paymentMethod = "Card";

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    return Scaffold(
      backgroundColor: appColor.Primary, // Background for the top part
      appBar: AppBar(
        backgroundColor: appColor.Primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: appColor.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Payment",
          style: TextStyle(
            color: appColor.white,
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
          Text(
            "\$ 100.00",
            style: TextStyle(
              color: appColor.white,
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
              decoration: BoxDecoration(color: appColor.white),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 1. Doctor Profile
                    _buildDoctorProfile(appColor),

                    const SizedBox(height: 20),
                    Divider(color: appColor.secondary, thickness: 1.5),
                    const SizedBox(height: 20),

                    // 2. Booking Details
                    _buildDetailRow(
                      "Date / Hour",
                      "Month 24, Year / 10:00 AM",
                      appColor,
                    ),
                    const SizedBox(height: 15),
                    _buildDetailRow("Duration", "30 Minutes", appColor),
                    const SizedBox(height: 15),
                    _buildDetailRow("Booking for", "Another Person", appColor),

                    const SizedBox(height: 20),
                    Divider(color: appColor.secondary, thickness: 1.5),
                    const SizedBox(height: 20),

                    // 3. Cost Breakdown
                    _buildDetailRow("Amount", "\$100.00", appColor),
                    const SizedBox(height: 15),
                    _buildDetailRow("Duration", "30 Minutes", appColor),
                    const SizedBox(height: 20),

                    // Total Row (Slightly different styling)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            color: appColor.fontColor,
                            fontSize: 16,
                            fontFamily: "LeagueSpartan",
                          ),
                        ),
                        Text(
                          "\$100",
                          style: TextStyle(
                            color: appColor.fontColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "LeagueSpartan",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Divider(color: appColor.secondary, thickness: 1.5),
                    const SizedBox(height: 20),

                    // 4. Payment Method
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Method",
                          style: TextStyle(
                            color: appColor.fontColor,
                            fontSize: 15,
                            fontFamily: "LeagueSpartan",
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              _paymentMethod,
                              style: TextStyle(
                                color: appColor.fontColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "LeagueSpartan",
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentMethod(),
                                  ),
                                );
                                if (result != null) {
                                  setState(() {
                                    _paymentMethod = result;
                                  });
                                }
                              }, // Add change logic
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  color: appColor.Primary, // Blue link color
                                  fontSize: 14,
                                  fontFamily: "LeagueSpartan",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // 5. Pay Now Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_paymentMethod == "Card") {
                            StripeServices.instance.makePayment();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColor.Primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Pay Now",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: appColor.white,
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
  Widget _buildDoctorProfile(AppColor appColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        const CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage(
            "assets/icons/Doctors/images/doctor1.png",
          ),
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
                  Flexible(
                    child: Text(
                      "Dr. Olivia Turner, M.D.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: appColor.Primary,
                        fontFamily: "LeagueSpartan",
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.verified, color: appColor.Primary, size: 24),
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
                  _buildChip(Icons.star, "5", appColor),
                  const SizedBox(width: 10),
                  _buildChip(Icons.chat_bubble_outline, "60", appColor),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Helper Widget 2: Small Chips (Rating/Chat) ---
  Widget _buildChip(IconData icon, String text, AppColor appColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: appColor.secondary.withOpacity(0.5), // Light purple/blue bg
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: appColor.Primary),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: appColor.Primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget 3: Reusable Label-Value Row ---
  Widget _buildDetailRow(String label, String value, AppColor appColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: appColor.fontColor,
            fontSize: 15,
            fontFamily: "LeagueSpartan",
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: appColor.fontColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: "LeagueSpartan",
          ),
        ),
      ],
    );
  }
}
