import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../../entity/appointment.dart';
import '../widgets/appointment_card.dart';

// --- 3. MAIN SCREEN ---
class AllAppointmentsScreen extends StatelessWidget {
  const AllAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppointmentViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "All Appointments",
        onPressed: () => viewModel.goBack(context),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // --- TAB BUTTONS ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: LightColorPalette.inputField,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTabButton("Completed", AppointmentStatus.completed, viewModel),
                  _buildTabButton("Upcoming", AppointmentStatus.upcoming, viewModel),
                  _buildTabButton("Cancelled", AppointmentStatus.cancelled, viewModel),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // --- LIST VIEW ---
          Expanded(
            child: 
            _buildAppointmentList(viewModel),
          ),
        ],
      ),
    );
  }

  // Helper for Tabs
  Widget _buildAppointmentList(AppointmentViewModel viewModel) {
    final currentList = viewModel.currentDisplayedList;
    final isLoading = viewModel.isCurrentListLoading;

    if (isLoading && currentList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (currentList.isEmpty) {
      return const Center(child: Text("No appointments found"));
    }

    return RefreshIndicator(
      onRefresh: () async {
        await viewModel.fetchAppointmentsByStatus(viewModel.selectedStatus.name);
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: currentList.length,
        itemBuilder: (context, index) {
          final item = currentList[index];
          return AppointmentCard(
            key: ValueKey(item.hashCode),
            appointment: item,
          );
        },
      ),
    );
  }

  // Helper for Tabs
  Widget _buildTabButton(String text, AppointmentStatus status, AppointmentViewModel viewModel) {
    final bool isSelected = viewModel.selectedStatus == status; // Let the ViewModel tell us if it's selected

    return Expanded(
      child: GestureDetector(
        onTap: () => viewModel.changeTab(status), // 👇 Delegate all logic to ViewModel!
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: AnimatedContainer( // Added a subtle animation for tab switching
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? LightColorPalette.primary : LightColorPalette.inputField,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : LightColorPalette.primary,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: "LeagueSpartan",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
