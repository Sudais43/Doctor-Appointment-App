import 'package:flutter/material.dart';
import 'package:skin_firts/feature/authentication/presentation/pages/login.dart';
import 'package:skin_firts/feature/authentication/presentation/pages/set_password.dart';
import 'package:skin_firts/feature/homePage/presentation/pages/home_page.dart';
import 'package:skin_firts/feature/homePage/presentation/widgets/doctor_tile.dart';

import 'feature/doctor_pages/presentation/pages/doctors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: DoctorListPage(),
    );
  }
}