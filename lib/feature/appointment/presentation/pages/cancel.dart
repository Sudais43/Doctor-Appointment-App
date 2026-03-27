import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';

class CancelAppointmentScreen extends StatefulWidget {
  final String appointmentId;
  const CancelAppointmentScreen({super.key, required this.appointmentId});

  @override
  State<CancelAppointmentScreen> createState() =>
      _CancelAppointmentScreenState();
}

class _CancelAppointmentScreenState extends State<CancelAppointmentScreen> {
  int _selectedReason = 1;
  bool _isCancelling = false;

  final TextEditingController _reasonController = TextEditingController();

  final List<String> _cancellationReasons = [
    "Rescheduling",
    "Weather Conditions",
    "Unexpected Work",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Cancel Appointment",
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- 1. Description Text ---
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  style: TextStyle(
                    fontSize: 14,
                    color: LightColorPalette.black,
                    fontFamily: "LeagueSpartan",
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),

                // --- 2. Radio Button List ---
                _buildRadioOption(0, _cancellationReasons[0]),
                const SizedBox(height: 12),
                _buildRadioOption(1, _cancellationReasons[1]),
                const SizedBox(height: 12),
                _buildRadioOption(2, _cancellationReasons[2]),
                const SizedBox(height: 12),
                _buildRadioOption(3, _cancellationReasons[3]),

                const SizedBox(height: 30),

                // --- 3. Additional Reason Text ---
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(
                      0xFF8FA1D0,
                    ), // Light blue text color from image
                    fontFamily: "LeagueSpartan",
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 15),

                // --- 4. Text Input Field ---
                Container(
                  height: 170,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: LightColorPalette.inputField,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _reasonController,
                    maxLines: null, // Allow multiline input
                    expands: true, // Fill the container
                    decoration: const InputDecoration(
                      hintText: "Enter Your Reason Here...",
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

                const SizedBox(height: 40),

                // --- 5. Cancel Button ---
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isCancelling ? null : _handleCancelAppointment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightColorPalette.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child:
                        _isCancelling
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              "Cancel Appointment",
                              style: TextStyle(
                                fontSize: 18,
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
    );
  }

  Future<void> _handleCancelAppointment() async {
    setState(() => _isCancelling = true);

    String reason = _cancellationReasons[_selectedReason];
    if (_selectedReason == 3) {
      // "Others"
      if (_reasonController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter a reason when selecting 'Others'."),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _isCancelling = false);
        return;
      }
      reason = _reasonController.text.trim();
    }

    try {
      final viewModel = context.read<AppointmentViewModel>();
      final success = await viewModel.cancelAppointment(
        appointmentId: widget.appointmentId,
        reason: reason,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Appointment cancelled successfully."),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to cancel appointment. Please try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCancelling = false);
      }
    }
  }

  Widget _buildRadioOption(int value, String text) {
    final bool isSelected = _selectedReason == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedReason = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          // Only show background color if selected, matches image
          color: isSelected ? const Color(0xFFD6E4FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            // Custom Radio Button
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected
                          ? LightColorPalette.primary
                          : LightColorPalette.secondary,
                  width: 2,
                ),
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: LightColorPalette.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                      : null,
            ),
            const SizedBox(width: 12),
            // Text
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: LightColorPalette.black, // Dark text for readability
                fontWeight: FontWeight.w400,
                fontFamily: "LeagueSpartan",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }
}
