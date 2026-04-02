import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/view_model/doctor_view_model.dart';

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
  // Only UI-specific controllers remain here
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Reset state in case it was left dirty from a previous visit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DoctorViewModel>().resetReviewState();
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the ViewModel for changes (rating, loading state)
    final viewModel = context.watch<DoctorViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Add Review",
        onPressed: () => Navigator.of(context).pop(),
      ),
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Your feedback helps us improve our services and helps other patients choose the right doctor.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          color: LightColorPalette.black,
                          fontFamily: "LeagueSpartan",
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Doctor Image
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(widget.image),
                    ),
                    const SizedBox(height: 20),

                    // Doctor Details
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

                    // Rating Row
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: LightColorPalette.secondary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: LightColorPalette.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 15),

                        // Rating Stars (Controlled by ViewModel)
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
                                onTap:
                                    () => viewModel.setRating(
                                      index + 1,
                                    ), // 👇 Delegate to ViewModel
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 2.0,
                                  ),
                                  child: Icon(
                                    index < viewModel.currentRating
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

                    // Comment Input
                    Container(
                      height: 180,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: LightColorPalette.inputField,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _commentController,
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                          hintText: "Enter Your Comment Here...",
                          hintStyle: TextStyle(
                            color: Color(0xFF8FA1D0),
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

            // --- Bottom Button ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: 300,
                height: 55,
                child: ElevatedButton(
                  // 👇 Delegate submission to ViewModel
                  onPressed:
                      viewModel.isSubmittingReview
                          ? null
                          : () => viewModel.submitDoctorReview(
                            context: context,
                            doctorId: widget.doctorId,
                            comment: _commentController.text,
                          ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightColorPalette.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child:
                      viewModel.isSubmittingReview
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
}
