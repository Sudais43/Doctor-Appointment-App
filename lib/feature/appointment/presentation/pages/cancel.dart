import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';

class CancelAppointmentScreen extends StatefulWidget {
  final String appointmentId;
  const CancelAppointmentScreen({super.key, required this.appointmentId});

  @override
  State<CancelAppointmentScreen> createState() => _CancelAppointmentScreenState();
}

class _CancelAppointmentScreenState extends State<CancelAppointmentScreen> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ensure fresh state when opening the screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppointmentViewModel>().resetCancelState();
    });
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the ViewModel for changes
    final viewModel = context.watch<AppointmentViewModel>();

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
                  "Please select the reason for cancellation. Note that frequent cancellations may affect your profile ranking.",
                  style: TextStyle(
                    fontSize: 14,
                    color: LightColorPalette.black,
                    fontFamily: "LeagueSpartan",
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),

                // --- 2. Radio Button List ---
                // We map through the reasons from the ViewModel directly!
                ...List.generate(
                  viewModel.cancellationReasons.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _buildRadioOption(index, viewModel.cancellationReasons[index], viewModel),
                  ),
                ),

                const SizedBox(height: 18),

                // --- 3. Additional Reason Text ---
                const Text(
                  "If 'Others', please specify your reason below:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8FA1D0),
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
                    maxLines: null,
                    expands: true,
                    // Disable the text field if they haven't selected "Others" (Index 3)
                    enabled: viewModel.selectedCancelReasonIndex == 3, 
                    decoration: InputDecoration(
                      hintText: "Enter Your Reason Here...",
                      hintStyle: const TextStyle(
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
                    // 👇 Delegate submission logic entirely to the ViewModel
                    onPressed: viewModel.isCancellingAppointment 
                        ? null 
                        : () => viewModel.processCancellation(
                              context: context,
                              appointmentId: widget.appointmentId,
                              customReasonText: _reasonController.text,
                            ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightColorPalette.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: viewModel.isCancellingAppointment
                        ? const CircularProgressIndicator(color: Colors.white)
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

  Widget _buildRadioOption(int index, String text, AppointmentViewModel viewModel) {
    final bool isSelected = viewModel.selectedCancelReasonIndex == index;

    return GestureDetector(
      onTap: () {
        // 👇 Tell the ViewModel the user tapped a radio button
        viewModel.setCancelReasonIndex(index);
        // If they switch away from "Others", clear the text field
        if (index != 3) {
          _reasonController.clear();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD6E4FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? LightColorPalette.primary : LightColorPalette.secondary,
                  width: 2,
                ),
              ),
              child: isSelected
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
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: LightColorPalette.black,
                fontWeight: FontWeight.w400,
                fontFamily: "LeagueSpartan",
              ),
            ),
          ],
        ),
      ),
    );
  }
}