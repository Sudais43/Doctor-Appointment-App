import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/view_model/doctor_view_model.dart';
import 'package:skin_firts/core/widget/custom_snackbar.dart';

class ReviewScreen extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String doctorSpeciality;
  final String image;
  const ReviewScreen({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpeciality,
    required this.image,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _rating = 3;
  bool _isSubmitting = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Add Review", onPressed: () {}),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Top Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          color: LightColorPalette.black,
                          fontFamily: "LeagueSpartan",
                          height: 1.4, // Line height for readability
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Doctor Image
                    CircleAvatar(
                      radius: 60, // Large size (120px diameter)
                      backgroundImage: AssetImage(widget.image),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      widget.doctorName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: LightColorPalette.primary,
                        fontFamily: "LeagueSpartan",
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.doctorSpeciality,
                      style: const TextStyle(
                        fontSize: 14,
                        color: LightColorPalette.black,
                        fontFamily: "LeagueSpartan",
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: LightColorPalette.secondary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: LightColorPalette.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Rating Stars
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: LightColorPalette.secondary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _rating = index + 1;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 2.0,
                                  ),
                                  child: Icon(
                                    index < _rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: LightColorPalette.primary,
                                    size: 24,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Comment
                    Container(
                      height: 180, // Fixed height for large box
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: LightColorPalette.inputField,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _commentController,
                        maxLines: null, // Allow multiline
                        expands: true,
                        decoration: const InputDecoration(
                          hintText: "Enter Your Comment Here...",
                          hintStyle: TextStyle(
                            color: Color(
                              0xFF8FA1D0,
                            ), // Specific placeholder color
                            fontSize: 14,
                            fontFamily: "LeagueSpartan",
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: LightColorPalette.black,
                          fontFamily: "LeagueSpartan",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- 6. Bottom Button ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: 300,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightColorPalette.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child:
                      _isSubmitting
                          ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text(
                            "Add Review",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: "LeagueSpartan",
                            ),
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReview() async {
    if (_commentController.text.trim().isEmpty) {
      CustomSnackBar.show(
        context,
        message: "Please write a comment before submitting",
        isError: true,
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    bool isSuccess = await context.read<DoctorViewModel>().submitReviews(
      widget.doctorId,
      _rating.toDouble(),
      _commentController.text.trim(),
    );

    if (!mounted) return;

    if (isSuccess) {
      CustomSnackBar.show(
        context,
        message: "Thank you for your review!",
        isError: false,
      );

      Navigator.pop(context, true); // Return true on success
    } else {
      CustomSnackBar.show(
        context,
        message: "Failed to submit review, please try again",
        isError: true,
      );
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
