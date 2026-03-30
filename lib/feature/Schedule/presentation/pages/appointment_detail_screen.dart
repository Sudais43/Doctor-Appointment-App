import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/theme/theme_extension.dart';
import 'package:skin_firts/feature/homePage/presentation/widgets/doctor_tile.dart';
import 'package:skin_firts/feature/payment/presentation/pages/payment_screen.dart';

class AppointmentDetailScreen extends StatelessWidget {
  //for Doctor Details
  final String doctorId;
  final String doctorName;
  final String image;
  final String speciality;
  final bool isFavorite;
  final double rating;
  final int reviewsCount;
  //
  final String bookingFor;
  final String fullName;
  final String age;
  final String gender;
  final String problem;
  final String date;
  final String time;

  const AppointmentDetailScreen({
    super.key,
    required this.doctorId,
    required this.bookingFor,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.problem,
    required this.date,
    required this.time,
    required this.doctorName,
    required this.image,
    required this.speciality,
    required this.isFavorite,
    required this.rating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(color: appColor.Primary),
        title: Text(
          "Your Appointment",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: appColor.Primary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: 370,
                child: DoctorTile1(
                  doctorName: doctorName,
                  isFavorite: isFavorite,
                  specialization: speciality,
                  reviews: reviewsCount,
                  rating: rating,
                  imageUrl: image,
                  onFavoriteTap: () {},
                ),
              ),
            ),
            SizedBox(height: 20),

            Divider(
              color: LightColorPalette.primary,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: LightColorPalette.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            date,
                            // "Month 24, Year",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: LightColorPalette.white,
                              fontFamily: "League Spartan",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          time,
                          // "WED, 10:00 AM",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: LightColorPalette.primary,
                            fontFamily: "League Spartan",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => PaymentScreen(
                                    doctorId: doctorId,
                                    doctorName: doctorName,
                                    speciality: speciality,
                                    image: image,
                                    date: date,
                                    time: time,
                                    bookingFor: bookingFor,
                                    amount: '30',
                                    selectedDate: DateTime.now(),
                                    timeSlot: time,
                                    fullName: fullName,
                                    age: age,
                                    gender: gender,
                                    problem: problem,
                                    duration: '30',
                                     reviews: reviewsCount, 
                                     rating: rating,
                                  ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 26,
                          width: 26,
                          child: CircleAvatar(
                            backgroundColor: LightColorPalette.primary,
                            child: Icon(
                              Icons.check,
                              color: LightColorPalette.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 26,
                        height: 26,
                        child: CircleAvatar(
                          // radius: 10,
                          backgroundColor: LightColorPalette.primary,
                          child: Icon(
                            Icons.close,
                            color: LightColorPalette.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Divider(
              color: LightColorPalette.primary,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 10),

            rec_table("Booking for", bookingFor),
            rec_table("Full Name", fullName),
            rec_table("Age", age),
            rec_table("Gender", gender),

            SizedBox(height: 10),
            Divider(
              color: LightColorPalette.primary,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Problem",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: LightColorPalette.black,
                  fontFamily: "League Spartan",
                ),
              ),
            ),

            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                problem,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: LightColorPalette.black,
                  fontFamily: "League Spartan",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rec_table(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: LightColorPalette.black,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: LightColorPalette.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
