import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';

import '../widgets/payment_option_tile.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethod> {
  int _selectedPaymentMethod = 0;
  final List<String> _paymentMethodNames = [
    "Card",
    "Apple Pay",
    "Paypal",
    "Google Pay",
  ];

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    return Scaffold(
      backgroundColor: appColor.white,
      appBar: CustomAppBar(
        title: "Payment Method",
        onPressed: () => Navigator.pop(context),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, _paymentMethodNames[_selectedPaymentMethod]);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 55),
            backgroundColor: appColor.Primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            "Confirm",
            style: TextStyle(
              color: appColor.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "LeagueSpartan",
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SECTION 1: Credit Card ---
              const Text(
                "Credit & Debit Card",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily:
                      "LeagueSpartan", // Ensure this font is added in pubspec
                ),
              ),
              const SizedBox(height: 15),

              PaymentOptionTile(
                icon: Icons.credit_card,
                title: "Card",
                value: 0,
                groupValue: _selectedPaymentMethod,
                primaryColor: LightColorPalette.primary,
                onTap: (val) => setState(() => _selectedPaymentMethod = val),
              ),

              const SizedBox(height: 30),

              // --- SECTION 2: More Options ---
              const Text(
                "More Payment Option",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black, // Underline style from image
                  decorationColor: Colors.black,
                  fontFamily: "LeagueSpartan",
                ),
              ),
              const SizedBox(height: 15),

              // Apple Pay
              PaymentOptionTile(
                icon: Icons.apple,
                title: "Apple Pay",
                value: 1,
                groupValue: _selectedPaymentMethod,
                primaryColor: LightColorPalette.primary,
                onTap: (val) => setState(() => _selectedPaymentMethod = val),
              ),

              const SizedBox(height: 15),

              // Paypal
              PaymentOptionTile(
                icon:
                    Icons
                        .paypal, // Note: Use font_awesome_flutter or SVG for exact logo
                title: "Paypal",
                value: 2,
                groupValue: _selectedPaymentMethod,
                primaryColor: LightColorPalette.primary,
                onTap: (val) => setState(() => _selectedPaymentMethod = val),
              ),

              const SizedBox(height: 15),

              // Google Pay
              PaymentOptionTile(
                icon: Icons.g_mobiledata, // Replace with your Google Pay SVG
                title: "Google Pay",
                value: 3,
                groupValue: _selectedPaymentMethod,
                primaryColor: LightColorPalette.primary,
                onTap: (val) => setState(() => _selectedPaymentMethod = val),
              ),

              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
