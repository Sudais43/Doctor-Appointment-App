import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/color_palette.dart';

class AppointmentDetailScreen extends StatelessWidget {
  const AppointmentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // DoctorTile(doctorName: doctor.name, speciality: '', image: '', isFavorite: null,),
            children: [
              Divider(
                color: LightColorPalette.primary,
                indent: 20,
                endIndent: 20,
              ),

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
                              "Month 24, Year",
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
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "WED, 10:00 AM",
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
                        SizedBox(
                          height: 26,
                          width: 26,
                          child: CircleAvatar(
                            backgroundColor: LightColorPalette.primary,
                            child: Icon(Icons.check, color: LightColorPalette.white, size: 18,),
                          ),
                        ),
                        SizedBox(width: 10,),
                        SizedBox(
                          width: 26,
                          height: 26,
                          child: CircleAvatar(
                            // radius: 10,
                            backgroundColor: LightColorPalette.primary,
                            child: Icon(Icons.close, color: LightColorPalette.white, size: 18,),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),


              Divider(
                color: LightColorPalette.primary,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(height: 10,),
              
              rec_table("Booking for", "Another Person"),
              rec_table("Full Name", "Dr. Muhammad Sudais"),
              rec_table("Age", "30"),
              rec_table("Gender", "Male"),

              SizedBox(height: 10,),
              Divider(
                color: LightColorPalette.primary,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(height: 10,),

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

              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 300,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: LightColorPalette.black,
                      fontFamily: "League Spartan",
                    ),
                  ),
                ),
              ),



            ],
          ),
      ),
    );
  }

  Widget rec_table(String title, String value){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
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
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: LightColorPalette.black,
            ),
          ),
        ],
      ),
    );
  }
}
