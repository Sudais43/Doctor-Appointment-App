import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/feature/Schedule/presentation/pages/appointment_detail_screen.dart';
import 'package:skin_firts/feature/Schedule/presentation/pages/rough.dart';
import 'package:skin_firts/feature/Schedule/presentation/widgets/booking_type_selector.dart';
import 'package:skin_firts/feature/Schedule/presentation/widgets/day_capsule.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';
import 'package:skin_firts/feature/authentication/presentation/widgets/custom_input_field.dart';
import '../widgets/gender_selector.dart';

class ScheduleScreen extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String image;
  final String speciality;
  final bool isFavorite;
  final double rating;
  final int review;
  final List<dynamic> availability; // Add this to receive the doctor's schedule
  const ScheduleScreen({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.availability,
    required this.image,
    required this.speciality,
    required this.isFavorite,
    required this.rating,
    required this.review,
  });

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // DateTime? _selectedDate;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();

  late List<DateTime> _dates;
  // int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    final startDate = DateTime.now();
    _dates = List.generate(30, (index) => startDate.add(Duration(days: index)));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint("Doctor ID: ${widget.doctorId}");
      context.read<AppointmentViewModel>().fetchAvailableSlots(
        widget.doctorId,
        startDate,
      );
    });
  }

  bool _checkIfDoctorWorks(DateTime date) {
    // Convert 1-7 (Mon-Sun) to English Day Name
    final String dayName =
        [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ][date.weekday - 1];

    // Check if this day name exists in the doctor's availability list
    return widget.availability.any((a) => a['day'] == dayName);
  }

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    final appointmentVM = context.watch<AppointmentViewModel>();
    return Scaffold(
      appBar: CustomDetailAppBar(doctorName: widget.doctorName),
      bottomNavigationBar: _SubmitButton(appointmentVM, appColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: appColor.secondary,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: _dates.length,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 43.0,
                                  ),
                                  itemBuilder: (context, index) {
                                    final date = _dates[index];
                                    final isSelected = appointmentVM.isSameDay(
                                      date,
                                      appointmentVM.selectedDate,
                                    );
                                    final bool isDoctorAvailable =
                                        _checkIfDoctorWorks(date);
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: DayCapsule(
                                        date: date,
                                        isSelected: isSelected,
                                        isAvailable:
                                            isDoctorAvailable, // Now dynamically greyed out if not a working day
                                        onTap: () {
                                          if (!isDoctorAvailable) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Doctor is not available on this day",
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                          appointmentVM.setSelectedDate(date);
                                          appointmentVM.fetchAvailableSlots(
                                            widget.doctorId,
                                            date,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),

                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 10,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios_new),
                              color: appColor.Primary,
                              onPressed: () {
                                _scrollController.animateTo(
                                  _scrollController.offset - 70,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 10,
                            child: IconButton(
                              onPressed: () {
                                _scrollController.animateTo(
                                  _scrollController.offset + 60,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              },
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                              color: appColor.Primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      "Available time",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1,
                        fontWeight: FontWeight.w500,
                        fontFamily: "LeagueSpartan",
                        color: appColor.Primary,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child:
                        appointmentVM.isBooking
                            ? const Center(child: CircularProgressIndicator())
                            : GridView.builder(
                              itemCount: appointmentVM.availableSlots.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    childAspectRatio: 2.8,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 10,
                                  ),
                              itemBuilder: (context, index) {
                                // final slotData = timeSlots[index];
                                final slotData =
                                    appointmentVM.availableSlots[index];
                                // final isSelected = _selectedIndex == index;
                                debugPrint(
                                  "Available Slots ${appointmentVM.availableSlots}",
                                );

                                return _buildTimeChip(
                                  slotData,
                                  appointmentVM,
                                  appColor,
                                );
                              },
                            ),
                  ),
                ],
              ),
              Divider(
                color: appColor.Primary,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 10),
                child: Text(
                  "Patient Details",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1,
                    fontWeight: FontWeight.w500,
                    fontFamily: "LeagueSpartan",
                    color: appColor.Primary,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 10),
                child: BookingTypeSelector(
                  onSelectionChanged: (value) {
                    appointmentVM.setPatientType(value);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 22.0, top: 10),
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: appColor.fontColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: CustomInputField(
                  label: "Name",
                  controller: nameController,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 22.0, top: 10),
                child: Text(
                  "Age",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: appColor.fontColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: CustomInputField(label: "30", controller: ageController),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 10),
                child: Text(
                  "Gender",
                  style: TextStyle(
                    fontSize: 14,
                    height: 1,
                    fontWeight: FontWeight.w500,
                    fontFamily: "LeagueSpartan",
                    color: appColor.Primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: GenderSelector(
                  onSelectionChanged: (value) {
                    appointmentVM.setSelectedGender(value);
                  },
                ),
              ),

              Divider(
                color: appColor.Primary,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 35.0, top: 10),
                child: Text(
                  "Describe your problem",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: appColor.fontColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: appColor.secondary, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _problemController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Enter your problem here....",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontFamily: "LeagueSpartan",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: appColor.fontColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _SubmitButton(AppointmentViewModel vm, AppColor color) {
    final String dayName =
        DateFormat('EEE').format(vm.selectedDate).toUpperCase();
    final String formattedDate = DateFormat(
      'MMMM d, yyyy',
    ).format(vm.selectedDate);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color.Primary),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => AppointmentDetailScreen(
                    bookingFor: vm.patientType,
                    fullName: nameController.text,
                    age: ageController.text,
                    gender: vm.selectedGender,
                    problem: _problemController.text,
                    date: formattedDate,
                    time: "$dayName, ${vm.selectedTimeSlot}",
                    doctorName: widget.doctorName,
                    image: widget.image,
                    speciality: widget.speciality,
                    isFavorite: widget.isFavorite,
                    rating: widget.rating,
                    reviewsCount: widget.review, 
                    doctorId: widget.doctorId,
                  ),
            ),
          );
        },
        child: Text(
          "proceed",
          style: TextStyle(
            color: color.white,
            fontSize: 16,
            fontFamily: "LeagueSpartan",
          ),
        ),
      ),
    );
  }

  Widget _buildTimeChip(
    dynamic slot,
    AppointmentViewModel VM,
    AppColor appColor,
  ) {
    // Based on your backend, the 'slot' is a Map like {'time': '09:00 AM', 'isBooked': false}
    final time = slot['time'] ?? 'Unknown';
    final bool isBooked = slot['isBooked'] ?? false;

    // 1. Determine Styles based on State
    Color backgroundColor;
    Color textColor;
    final bool isSelected = VM.selectedTimeSlot == time;

    if (isBooked) {
      // Disabled Style (Grey/Blue-ish mix from image)
      backgroundColor = appColor.white;
      textColor = appColor.secondary;
    } else if (isSelected) {
      // Selected Style (Bright Blue)
      backgroundColor = appColor.Primary;
      textColor = appColor.white;
    } else {
      // Available Style (Light Blue)
      backgroundColor = appColor.secondary; // Very light blue
      textColor = appColor.fontColor; // Muted blue text
    }

    return GestureDetector(
      onTap: () => isBooked ? null : VM.setSelectedTimeSlot(time),
      // onTap: () {
      //   // Only allow selection if not booked
      //   if (slot.status != TimeStatus.booked) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //     print("Selected Time: ${slot.time}");
      //   }
      // },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20), // Rounded pill shape
        ),
        alignment: Alignment.center,
        child: Text(
          time,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: "LeagueSpartan",
          ),
        ),
      ),
    );
  }
}
