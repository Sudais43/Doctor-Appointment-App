import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:skin_firts/feature/Schedule/presentation/widgets/doctor_profile_appbar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/theme/color_palette.dart';
import '../../data/dates_data.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<DoctorProfile> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DoctorProfileAppbar(
        onBackButtonPressed: () {},
        onSchedulePressed: () {},
        onCallPressed: () {},
        onVideoCallPressed: () {},
        onChatPressed: () {},
        onHelpPressed: () {},
        onFavoritePressed: () {},
      ),
      body: SafeArea(
        child: Center(
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 283,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: LightColorPalette.secondary,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 140,
                              width: 140,
                              child: CircleAvatar(
                                backgroundImage:
                                    Image.asset(
                                      "assets/icons/Doctors/images/doctor1.png",
                                    ).image,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Container(
                                  height: 27,
                                  width: 108,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: LightColorPalette.primary,
                                  ),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                        ),
                                        child: SizedBox(
                                          height: 21,
                                          width: 21,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                LightColorPalette.secondary,
                                            child: SvgPicture.asset(
                                              "assets/icons/HomeScreen/badge_icon.svg",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        "15 Years \n experience",
                                        style: TextStyle(
                                          fontSize: 12,
                                          height: 1,
                                          fontWeight: FontWeight.w300,
                                          color: LightColorPalette.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 108,
                                  width: 108,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: LightColorPalette.primary,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 12,
                                            height: 1.1,
                                            fontFamily: "LeagueSpartan",
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "Focus: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  "The impact of hormonal imbalances on skin conditions, specializing in acne, hirsutism, and other skin disorders.",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 39,
                          width: 257,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: LightColorPalette.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Dr. Alexander Bennett, Ph.D.",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                  color: LightColorPalette.primary,
                                  fontFamily: "LeagueSpartan",
                                ),
                              ),
                              Text(
                                "Dermato-Genetics",
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1,
                                  fontWeight: FontWeight.w300,
                                  color: LightColorPalette.black,
                                  fontFamily: "LeagueSpartan",
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 43,
                              height: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: LightColorPalette.white,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/HomeScreen/star_filled_icon.svg",
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "5",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: LightColorPalette.primary,
                                      fontFamily: "League Spartan",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 43,
                              height: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: LightColorPalette.white,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/HomeScreen/message_icon.svg",
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "60",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: LightColorPalette.primary,
                                      fontFamily: "League Spartan",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: LightColorPalette.white,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/HomeScreen/time_icon.svg",
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Mon-Sat / 9:00AM-5:00PM",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: LightColorPalette.primary,
                                      fontFamily: "League Spartan",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        // Icons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 82,
                              height: 21,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: LightColorPalette.primary,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/Doctors/calender_icon.svg",
                                    color: LightColorPalette.white,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    "Schedule",
                                    style: TextStyle(
                                      color: LightColorPalette.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "League Spartan",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: SizedBox(
                                    height: 21,
                                    width: 21,
                                    child: CircleAvatar(
                                      backgroundColor: LightColorPalette.white,
                                      child: SvgPicture.asset(
                                        "assets/icons/HomeScreen/info_mark.svg",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: SizedBox(
                                    height: 21,
                                    width: 21,
                                    child: CircleAvatar(
                                      backgroundColor: LightColorPalette.white,
                                      child: SvgPicture.asset(
                                        "assets/icons/Doctors/question_mark_icon.svg",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: SizedBox(
                                    height: 21,
                                    width: 21,
                                    child: CircleAvatar(
                                      backgroundColor: LightColorPalette.white,
                                      child: SvgPicture.asset(
                                        "assets/icons/HomeScreen/star_outline_icon.svg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: SizedBox(
                                    height: 21,
                                    width: 21,
                                    child: CircleAvatar(
                                      backgroundColor: LightColorPalette.white,
                                      child: SvgPicture.asset(
                                        "assets/icons/HomeScreen/favorite_filled_icon.svg",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: 285,
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        color: LightColorPalette.primary,
                        fontFamily: "LeagueSpartan",
                      ),
                    ),
                  ),

                  SizedBox(height: 7),

                  SizedBox(
                    width: 285,
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        height: 1,
                        color: LightColorPalette.black,
                        fontFamily: "LeagueSpartan",
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  _buildCalendar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      height: 360,
      color: LightColorPalette.secondary,
      child: Column(
        children: [
          _buildCustomHeader(),

          // 3. Custom Days (Blue Background)
          _buildCustomDaysOfWeek(),

          const SizedBox(height: 15),

          // 4. The Calendar Grid (White Background)
          Container(
            width: 320,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white, // White Box
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            padding: const EdgeInsets.all(10),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,

              // --- CRITICAL SETTINGS ---
              headerVisible: false, // Hide default header
              daysOfWeekVisible: false, // Hide default days
              rowHeight: 30,

              // --- LOGIC ---
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              enabledDayPredicate:
                  (day) => availableDates.contains(
                    DateTime.utc(day.year, day.month, day.day),
                  ),

              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },

              // --- YOUR STYLING BUILDERS ---
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: LightColorPalette.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: LightColorPalette.primary,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
                defaultBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
                disabledBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
                outsideBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: LightColorPalette.primary,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              // Go back one month
              _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
            });
          },
        ),
        const SizedBox(width: 10),
        Text(
          DateFormat(
            'MMMM',
          ).format(_focusedDay).toUpperCase(), // e.g., NOVEMBER
          style: const TextStyle(
            color: LightColorPalette.primary,
            fontSize: 14,
            fontFamily: "LeagueSpartan",
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(
            Icons.chevron_right,
            color: LightColorPalette.primary,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              // Go forward one month
              _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
            });
          },
        ),
      ],
    );
  }

  // --- HELPER 2: DAYS OF WEEK PILLS ---
  Widget _buildCustomDaysOfWeek() {
    final days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              days.map((day) {
                return Container(
                  width: 38,
                  height: 19,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: LightColorPalette.primary, // Blue Pill
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    day,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
