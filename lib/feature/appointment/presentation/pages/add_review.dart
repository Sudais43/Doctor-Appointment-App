import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/homePage/presentation/pages/bottom_navigation_bar.dart';


class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _rating = 3;
  final TextEditingController _commentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationbar1(),
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Add Review", onPressed: (){}),
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
                    const CircleAvatar(
                      radius: 60, // Large size (120px diameter)
                      backgroundImage: AssetImage("assets/icons/Doctors/images/doctor1.png"),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Dr. Olivia Turner, M.D.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: LightColorPalette.primary,
                        fontFamily: "LeagueSpartan",
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Dermato-Endocrinology",
                      style: TextStyle(
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
                            child: Icon(Icons.favorite, color: LightColorPalette.primary, size: 20)
                        ),
                        const SizedBox(width: 15),
                        // Rating Stars
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(
                                    index < _rating ? Icons.star : Icons.star_border,
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
                            color: Color(0xFF8FA1D0), // Specific placeholder color
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
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightColorPalette.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
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

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

}