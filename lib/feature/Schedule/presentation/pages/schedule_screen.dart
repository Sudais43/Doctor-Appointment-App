import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/app_color.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/feature/Schedule/data/dates_data.dart';
import 'package:skin_firts/feature/Schedule/presentation/pages/rough.dart';
import 'package:skin_firts/feature/Schedule/presentation/widgets/booking_type_selector.dart';
import 'package:skin_firts/feature/Schedule/presentation/widgets/day_capsule.dart';
import 'package:skin_firts/feature/authentication/presentation/widgets/custom_input_field.dart';

import '../../data/time_slots.dart';
import '../../domain/time_data_model.dart';
import '../widgets/gender_selector.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime? _selectedDate;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();

  late List<DateTime> _dates;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    final startDate = DateTime.utc(2025, 11, 1);
    _dates = List.generate(30, (index) => startDate.add(Duration(days: index)));

    // Find the first available date
    DateTime? firstAvailable;
    int firstAvailableIndex = -1;

    for (int i = 0; i < _dates.length; i++) {
      if (_isDateAvailable(_dates[i])) {
        firstAvailable = _dates[i];
        firstAvailableIndex = i;
        break;
      }
    }

    if (firstAvailable != null) {
      _selectedDate = firstAvailable;

      // Auto scroll to the available date after the first frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          // Assuming each item is roughly 60px wide + 8px padding
          double offset = firstAvailableIndex * 68.0;
          _scrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    } else {
      _selectedDate = _dates.first;
    }
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
    final appColor = context.appColors;
    return Scaffold(
      appBar: CustomDetailAppBar(),
      // bottomNavigationBar: BottomNavigationbar1(),
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
                                  itemBuilder: (context, index) {
                                    final date = _dates[index];
                                    final bool isSelected =
                                        _selectedDate != null &&
                                        isSameDay(date, _selectedDate!);
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
                    child: GridView.builder(
                      itemCount: timeSlots.length,
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
                        final slot = timeSlots[index];
                        final isSelected = _selectedIndex == index;
                        return _buildTimeChip(
                          slot,
                          isSelected,
                          index,
                          appColor,
                        );
                      },
                    ),
                  ),
                ],
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
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: appColor.fontColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: GenderSelector(onSelectionChanged: (value) {}),
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
                    color: LightColorPalette.black,
                  ),
                ),
              ),
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
                        hintText: "Describe your problem....",
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

  Widget _buildTimeChip(
    TimeSlot slot,
    bool isSelected,
    int index,
    AppColor appColor,
  ) {
    // 1. Determine Styles based on State
    Color backgroundColor;
    Color textColor;

    if (slot.status == TimeStatus.booked) {
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
