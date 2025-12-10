import 'package:flutter/material.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../../../homePage/presentation/pages/bottom_navigation_bar.dart';
import '../../data/appointment_data.dart';
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

  // Mock Data


  @override
  Widget build(BuildContext context) {
    // Filter list based on selection
    final filteredList = allAppointments
        .where((element) => element.status == _selectedStatus)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationbar1(),
      appBar: CustomAppBar(title: "All Appointments", onPressed: (){}),
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
                  _buildTabButton("Complete", AppointmentStatus.complete),
                  _buildTabButton("Upcoming", AppointmentStatus.upcoming),
                  _buildTabButton("Cancelled", AppointmentStatus.cancelled),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- LIST VIEW ---
          Expanded(
            child: filteredList.isEmpty
                ? const Center(child: Text("No appointments found"))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return AppointmentCard(
                  appointment: filteredList[index],
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
          setState(() {
            _selectedStatus = status;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? LightColorPalette.primary : LightColorPalette.secondary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : LightColorPalette.black,
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

