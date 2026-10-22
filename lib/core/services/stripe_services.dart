import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../API/api_keys.dart'; // Ensure this points to your secret key

class StripeServices {
  StripeServices._();
  static final StripeServices instance = StripeServices._();

  // Changed to return a boolean so the UI knows if it succeeded
  Future<bool> makePayment(int amount, String currency) async {
    try {
      // 1. Create Payment Intent
      String? paymentIntentClientSecret = await _createPaymentIntent(amount, currency);
      
      if (paymentIntentClientSecret == null) {
        throw Exception("Failed to initialize payment intent.");
      }

      // 2. Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Skin Flirt App", // Your app name
          // If you need Apple Pay / Google Pay, configure them here in the future
        ),
      );

      // 3. Present Payment Sheet
      // presentPaymentSheet handles the confirmation automatically. 
      // If the user cancels, it throws a StripeException.
      await Stripe.instance.presentPaymentSheet();
      
      return true; // Payment was successful!

    } on StripeException catch (e) {
      // The user canceled the payment or the card was declined
      debugPrint("Stripe Exception: ${e.error.localizedMessage}");
      throw Exception(e.error.localizedMessage ?? "Payment canceled or failed.");
    } catch (e) {
      // Any other error (e.g., network issue creating intent)
      debugPrint("General Stripe Error: $e");
      throw Exception("An unexpected error occurred during payment.");
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $secretKey",
          },
        ),
      );

      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      debugPrint("Error creating Payment Intent: $e");
      throw Exception("Failed to connect to payment gateway.");
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}