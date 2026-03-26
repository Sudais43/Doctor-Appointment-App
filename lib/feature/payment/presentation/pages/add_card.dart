import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/payment/presentation/widgets/credit_card.dart';
import 'package:skin_firts/core/services/stripe_services.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  // 1. Controllers (Good for final submission)
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  
  String _cardNumber = "0000 0000 0000 0000";
  String _cardHolderName = "John Doe";
  String _expiryDate = "MM/YY";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Add New Card", onPressed: (){}),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. THE CREDIT CARD PREVIEW ---

              CreditCard(
                  cardHolderName: _cardHolderName,
                  expiryDate: _expiryDate,
                  cardNumber: _cardNumber,
                  backgroundImage: "assets/icons/payment/card.png"),

              const SizedBox(height: 30),

              // --- 2. INPUT FIELDS ---

              _buildLabel("Card Holder Name"),
              _buildTextField(
                hint: "John Doe",
                controller: cardHolderNameController,
                // Update Name
                onChanged: (value) {
                  setState(() {
                    _cardHolderName = value.isEmpty ? "John Doe" : value;
                  });
                },
              ),

              const SizedBox(height: 20),

              _buildLabel("Card Number"),
              _buildTextField(
                hint: "0000 0000 0000 0000",
                keyboardType: TextInputType.number,
                controller: cardNumberController,
                // Update Number
                onChanged: (value) {
                  setState(() {
                    _cardNumber = value.isEmpty ? "0000 0000 0000 0000" : value;
                  });
                },
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Expiry Date"),
                        _buildTextField(
                          hint: "MM/YY",
                          keyboardType: TextInputType.datetime,
                          controller: expiryDateController,
                          // Update Expiry
                          onChanged: (value) {
                            setState(() {
                              _expiryDate = value.isEmpty ? "MM/YY" : value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("CVV"),
                        _buildTextField(
                          hint: "000",
                          keyboardType: TextInputType.number,
                          controller: cvvController,
                          // CVV usually doesn't update the front of the card
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // --- 3. SAVE BUTTON ---
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // StripeServices.instance.makePayment();
                    // print("Saved: $_cardHolderName");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightColorPalette.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Save Card",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Reusable Helper for Labels ---
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // --- Reusable Helper for TextFields ---
  // Updated to accept an onChanged function
  Widget _buildTextField({
    required String hint,
    TextInputType? keyboardType,
    TextEditingController? controller,
    required Function(String) onChanged, // ADDED THIS
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged, // CONNECTED HERE
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF7C9EFF)),
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        style: const TextStyle(
          color: Color(0xFF2962FF),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}