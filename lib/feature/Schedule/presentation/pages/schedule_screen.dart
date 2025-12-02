import 'package:flutter/material.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';
import 'package:skin_firts/feature/Schedule/data/dates_data.dart';
import 'package:skin_firts/feature/Schedule/presentation/widgets/booking_type_selector.dart';
import 'package:skin_firts/feature/Schedule/presentation/widgets/day_capsule.dart';
import 'package:skin_firts/feature/authentication/presentation/widgets/custom_input_field.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/time_slots.dart';
import '../../domain/time_data_model.dart';
import '../widgets/gender_selector.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedDate = DateTime.utc(2025, 11, 24);
  final ScrollController _scrollController = ScrollController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();

  late List<DateTime> _dates;
  int _selectedIndex = -1;

  @override
  void initState() {
    final startDate = DateTime.utc(2025, 11, 1);
    _dates = List.generate(30, (index) => startDate.add(Duration(days: index)));
    super.initState();
  }

  bool _isDateAvailable(DateTime date) {
    for (var availableDate in availableDates) {
      if (isSameDay(date, availableDate)) return true;
    }
    return false;
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: LightColorPalette.secondary,
              child: SizedBox(
                height: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      color: LightColorPalette.primary,
                      onPressed: () {
                        _scrollController.animateTo(
                          _scrollController.offset - 70,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                    ),

                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _dates.length,
                        itemBuilder: (context, index) {
                          final date = _dates[index];
                          final bool isSelected = isSameDay(
                            date,
                            _selectedDate,
                          );
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: DayCapsule(
                              date: date,
                              isSelected: isSelected,
                              isAvailable: _isDateAvailable(date),
                              onTap: () {
                                setState(() {
                                  _selectedDate = date;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        _scrollController.animateTo(
                          _scrollController.offset + 60,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      color: LightColorPalette.primary,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: const Text(
                      "Available time",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1,
                        fontWeight: FontWeight.w500,
                        fontFamily: "LeagueSpartan",
                        color: LightColorPalette.primary,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GridView.builder(
                      itemCount: timeSlots.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            childAspectRatio: 2.8,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10,
                          ),
                      itemBuilder: (context, index) {
                        final slot = timeSlots[index];
                        final isSelected = _selectedIndex == index;
                        return _buildTimeChip(slot, isSelected, index);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: LightColorPalette.primary,
              thickness: 2,
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
                  color: LightColorPalette.primary,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 10),
              child: BookingTypeSelector(onSelectionChanged: (value) {}),
            ),

            Text(
              "Name",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: LightColorPalette.black,
              ),
            ),
            CustomInputField(label: "Name", controller: nameController),

            Text(
              "Age",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: LightColorPalette.black,
              ),
            ),
            CustomInputField(label: "30", controller: ageController),

            Text(
              "Gender",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: LightColorPalette.black,
              ),
            ),
            GenderSelector(onSelectionChanged: (value) {}),

            Divider(
              color: LightColorPalette.primary,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            Text(
              "Describe your problem",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: LightColorPalette.black,
              ),
            ),
            Container(
              height: 110,
              width: 295,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: LightColorPalette.secondary,
                  width: 1,
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Describe your problem....",
                  hintStyle: TextStyle(
                    fontFamily: "LeagueSpartan",
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: LightColorPalette.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip(TimeSlot slot, bool isSelected, int index) {
    // 1. Determine Styles based on State
    Color backgroundColor;
    Color textColor;

    if (slot.status == TimeStatus.booked) {
      // Disabled Style (Grey/Blue-ish mix from image)
      backgroundColor = LightColorPalette.white;
      textColor = LightColorPalette.secondary;
    } else if (isSelected) {
      // Selected Style (Bright Blue)
      backgroundColor = LightColorPalette.primary;
      textColor = Colors.white;
    } else {
      // Available Style (Light Blue)
      backgroundColor = LightColorPalette.secondary; // Very light blue
      textColor = LightColorPalette.black; // Muted blue text
    }

    return GestureDetector(
      onTap: () {
        // Only allow selection if not booked
        if (slot.status != TimeStatus.booked) {
          setState(() {
            _selectedIndex = index;
          });
          print("Selected Time: ${slot.time}");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20), // Rounded pill shape
        ),
        alignment: Alignment.center,
        child: Text(
          slot.time,
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
