import 'package:flutter/material.dart';

// A reusable helper widget for a credit card design.
class CreditCard extends StatelessWidget {
  final String cardHolderName;
  final String expiryDate;
  final String cardNumber;
  final String backgroundImage;

  const CreditCard({
    super.key,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardNumber,
    required this.backgroundImage, // Path to your PNG background asset
  });

  @override
  Widget build(BuildContext context) {
    // AspectRatio ensures the card maintains a standard credit card shape.
    return AspectRatio(
      aspectRatio: 1.586,
      child: Stack(
        children: [
          // Background Image
          // We use a Container with a DecorationImage for the background.
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Rounded corners for the card
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.contain, // The image should cover the entire container
              ),
            ),
          ),
          // Card Content on top of the background
          // We use Padding to give the text some space from the edges.
          Positioned(
            top : 85,
            left: 30,
            child: Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Bottom section: Card Holder & Expiry
          Positioned(
            bottom: 55,
            left: 30,
            child: const Text(
              'Card Holder Name',
              style: TextStyle(
                color: Colors.white70, // Slightly transparent for the label
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 4), // Spacing between label and value
          Positioned(
            bottom: 35,
            left: 30,
            child: Text(
              cardHolderName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // Expiry Date Column
          Positioned(
            bottom: 55,
            right: 90,
            child: const Text(
              'Expiry Date',
              style: TextStyle(
                color: Colors.white70, // Slightly transparent for the label
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 4), // Spacing between label and value
          Positioned(
            bottom: 35,
            right: 100,
            child: Text(
              expiryDate,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
