import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/services/stripe_services.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';
import 'package:skin_firts/feature/payment/presentation/pages/payment_method.dart';
import 'package:skin_firts/core/widget/custom_snackbar.dart';
import 'package:skin_firts/feature/payment/presentation/pages/payment_successful.dart';

class PaymentScreen extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String speciality;
  final String image;
  final String date;
  final String time;
  final String duration;
  final String bookingFor;
  final String amount;
  final DateTime selectedDate;
  final String timeSlot;
  final String fullName;
  final String age;
  final String gender;
  final String problem;
  final int reviews;
  final double rating;

  const PaymentScreen({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.speciality,
    required this.image,
    required this.date,
    required this.time,
    required this.duration,
    required this.bookingFor,
    required this.amount,
    required this.selectedDate,
    required this.timeSlot,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.problem,
    required this.reviews,
    required this.rating,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _paymentMethod = "Card";
  bool _isProcessing = false; // Controls the loading spinner on the button

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;

    return Scaffold(
      backgroundColor: appColor.Primary,
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
            "\$ ${widget.amount}",
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
              decoration: BoxDecoration(
                color: appColor.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 1. Doctor Profile
                    _buildDoctorProfile(
                      appColor,
                      widget.image,
                      widget.doctorName,
                      widget.speciality,
                      widget.rating,
                      widget.reviews,
                    ),

                    const SizedBox(height: 20),
                    Divider(color: appColor.secondary, thickness: 1.5),
                    const SizedBox(height: 20),

                    // 2. Booking Details
                    _buildDetailRow(
                      "Date / Hour",
                      "${widget.date} / ${widget.timeSlot}",
                      appColor,
                    ),
                    const SizedBox(height: 15),
                    _buildDetailRow("Duration", widget.duration, appColor),
                    const SizedBox(height: 15),
                    _buildDetailRow("Booking for", widget.bookingFor, appColor),

                    const SizedBox(height: 20),
                    Divider(color: appColor.secondary, thickness: 1.5),
                    const SizedBox(height: 20),

                    // 3. Cost Breakdown
                    _buildDetailRow("Amount", "\$${widget.amount}", appColor),
                    const SizedBox(height: 15),
                    _buildDetailRow("Duration", widget.duration, appColor),
                    const SizedBox(height: 20),

                    // Total Row
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
                          "\$${widget.amount}",
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

                    // 4. Payment Method Selector
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
                                    builder: (context) => const PaymentMethod(),
                                  ),
                                );
                                if (result != null && mounted) {
                                  setState(() => _paymentMethod = result);
                                }
                              },
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  color: appColor.Primary,
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

                    // 5. PAY NOW BUTTON (With Safe Loading State)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed:
                            _isProcessing ? null : _processPaymentAndBooking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColor.Primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child:
                            _isProcessing
                                ? CircularProgressIndicator(
                                  color: appColor.white,
                                )
                                : Text(
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

  // --- THE CORE LOGIC FOR PAYMENT AND BOOKING ---
  // Future<void> _processPaymentAndBooking() async {
  //   if (!mounted) return;
  //   // 1. Start the loading spinner
  //   setState(() => _isProcessing = true);

  //   try {
  //     // 2. Process Stripe Payment (if applicable)
  //     if (_paymentMethod == "Card") {
  //       // This is the most likely place where the execution might hang.
  //       // The `makePayment` method in `StripeServices` must ensure its Future always completes,
  //       // either with a success or an error. If it hangs, the spinner will be stuck.
  //       await StripeServices.instance.makePayment();
  //     }

  //     // If we are here, payment was successful or not required.
  //     if (!mounted) return;

  //     // 3. Prepare Patient Data for Backend
  //     final patientDetails = {
  //       "fullName": widget.fullName,
  //       "age": widget.age,
  //       "gender": widget.gender,
  //       "problem": widget.problem,
  //       "bookingFor": widget.bookingFor,
  //     };

  //     // 4. Send Booking to Node.js via ViewModel
  //     // This is another potential point of failure if the network call hangs.
  //     bool bookingSuccess = await context
  //         .read<AppointmentViewModel>()
  //         .bookAppointment(
  //           doctorId: widget.doctorId,
  //           date: widget.selectedDate,
  //           time: widget.timeSlot,
  //           patientDetails: patientDetails,
  //         );

  //     if (!mounted) return;

  //     // 5. Handle Booking Success or Failure
  //     if (bookingSuccess) {
  //       _showSuccessDialog(context);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text(
  //             "Booking failed. Please try again or contact support.",
  //           ),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     if (!mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("An error occurred: $e"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   } finally {
  //     // 6. Stop the spinner safely
  //     if (mounted) {
  //       setState(() => _isProcessing = false);
  //     }
  //   }
  // }

  // --- THE CORE LOGIC FOR PAYMENT AND BOOKING ---
  Future<void> _processPaymentAndBooking() async {
    if (!mounted) return;

    setState(() => _isProcessing = true);

    try {
      bool paymentSuccessful = true;

      // 1. Process Stripe Payment
      if (_paymentMethod == "Card") {
        // Convert your string amount to an integer for Stripe (e.g. "100.00" -> 100)
        int stripeAmount = double.tryParse(widget.amount)?.toInt() ?? 100;

        // Await the new boolean method. If it fails, it will throw an error to the catch block.
        paymentSuccessful = await StripeServices.instance.makePayment(
          stripeAmount,
          "usd",
        );
      }

      // 2. If payment succeeded, proceed to booking
      if (paymentSuccessful) {
        if (!mounted) return;

        // Prepare Patient Data
        final patientDetails = {
          "fullName": widget.fullName,
          "age": widget.age,
          "gender": widget.gender,
          "problem": widget.problem,
          "bookingFor": widget.bookingFor,
        };

        // Send Booking to Node.js
        bool bookingSuccess = await context
            .read<AppointmentViewModel>()
            .bookAppointment(
              doctorId: widget.doctorId,
              date: widget.date,
              time: widget.timeSlot,
              patientDetails: patientDetails,
            );

        if (!mounted) return;

        if (bookingSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => PaymentSuccessScreen(
                    doctorName: widget.doctorName,
                    appointmentDate: widget.date,
                    appointmentTime: widget.timeSlot,
                  ),
            ),
          );
        } else {
          throw Exception("Booking failed on our end. Please contact support.");
        }
      }
    } catch (e) {
      if (!mounted) return;
      // This will now catch Stripe cancelations OR server booking failures
      CustomSnackBar.show(
        context,
        message: e.toString().replaceAll("Exception: ", ""),
        isError: true,
      );
    } finally {
      // 3. Always stop the spinner, no matter what happened
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  // --- Success Dialog ---
  // void _showSuccessDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder:
  //         (context) => AlertDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const Icon(Icons.check_circle, color: Colors.green, size: 80),
  //               const SizedBox(height: 20),
  //               const Text(
  //                 "Success!",
  //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //               ),
  //               const SizedBox(height: 10),
  //               const Text(
  //                 "Your appointment has been booked successfully.",
  //                 textAlign: TextAlign.center,
  //               ),
  //               const SizedBox(height: 20),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(); // Close dialog
  //                   Navigator.of(
  //                     context,
  //                   ).popUntil((route) => route.isFirst); // Go to Home
  //                 },
  //                 child: const Text("Done"),
  //               ),
  //             ],
  //           ),
  //         ),
  //   );
  // }

  // --- Helper Widgets ---
  Widget _buildDoctorProfile(
    AppColor appColor,
    String image,
    String name,
    String speciality,
    double rating,
    int reviews,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 35, backgroundImage: AssetImage(image)),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      name,
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
              Text(
                speciality,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontFamily: "LeagueSpartan",
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildChip(Icons.star, rating.toString(), appColor),
                  const SizedBox(width: 10),
                  _buildChip(
                    Icons.chat_bubble_outline,
                    reviews.toString(),
                    appColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip(IconData icon, String text, AppColor appColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: appColor.secondary.withOpacity(0.5),
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
