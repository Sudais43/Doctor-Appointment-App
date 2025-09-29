import 'package:flutter/material.dart';
import 'package:skin_firts/feature/authentication/presentation/pages/login.dart';
import 'package:skin_firts/feature/authentication/presentation/pages/login_2.dart';
import 'package:skin_firts/feature/authentication/presentation/pages/set_password.dart';
import 'package:skin_firts/feature/authentication/presentation/pages/sign_up.dart';
import 'package:skin_firts/feature/onboarding/presentation/pages/Registeration.dart';
import 'package:skin_firts/feature/onboarding/presentation/pages/SplashScreen.dart';

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
      home: SetPassword(),
    );
  }
}