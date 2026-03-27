import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../../entity/appointment.dart';
import '../widgets/appointment_card.dart';

// --- 3. MAIN SCREEN ---
class AllAppointmentsScreen extends StatefulWidget {
  const AllAppointmentsScreen({super.key});

  @override
  State<AllAppointmentsScreen> createState() => _AllAppointmentsScreenState();
}

class _AllAppointmentsScreenState extends State<AllAppointmentsScreen> {
  // Track selected tab
  AppointmentStatus _selectedStatus = AppointmentStatus.upcoming;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "All Appointments",
        onPressed: () => Navigator.of(context).pop(),
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
                  _buildTabButton("Completed", AppointmentStatus.completed),
                  _buildTabButton("Upcoming", AppointmentStatus.upcoming),
                  _buildTabButton("Cancelled", AppointmentStatus.cancelled),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- LIST VIEW ---
          Expanded(
            child: Consumer<AppointmentViewModel>(
              builder: (context, appointmentVM, child) {
                List<Appointment> currentList;
                bool isLoading;

                switch (_selectedStatus) {
                  case AppointmentStatus.upcoming:
                    currentList = appointmentVM.upcomingAppointments;
                    isLoading = appointmentVM.isLoadingUpcoming;
                    break;
                  case AppointmentStatus.completed:
                    currentList = appointmentVM.completedAppointments;
                    isLoading = appointmentVM.isLoadingCompleted;
                    break;
                  case AppointmentStatus.cancelled:
                    currentList = appointmentVM.cancelledAppointments;
                    isLoading = appointmentVM.isLoadingCancelled;
                    break;
                }

                if (isLoading && currentList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (currentList.isEmpty) {
                  return const Center(child: Text("No appointments found"));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await appointmentVM.fetchAppointmentsByStatus(
                      _selectedStatus.name,
                    );
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
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Tabs
  Widget _buildTabButton(String text, AppointmentStatus status) {
    final bool isSelected = _selectedStatus == status;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_selectedStatus == status) return;

          setState(() => _selectedStatus = status);

          final vm = context.read<AppointmentViewModel>();
          if (status == AppointmentStatus.completed &&
              vm.completedAppointments.isEmpty) {
            vm.fetchAppointmentsByStatus('completed');
          } else if (status == AppointmentStatus.cancelled &&
              vm.cancelledAppointments.isEmpty) {
            vm.fetchAppointmentsByStatus('cancelled');
          } else if (status == AppointmentStatus.upcoming &&
              vm.upcomingAppointments.isEmpty) {
            vm.fetchAppointmentsByStatus('upcoming');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? LightColorPalette.primary
                      : LightColorPalette.inputField,
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
