import 'package:flutter/material.dart';
import 'package:skin_firts/feature/appointment/presentation/pages/all_appointment.dart';
import 'package:skin_firts/feature/payment/presentation/pages/add_card.dart';
import 'package:skin_firts/feature/payment/presentation/pages/payment_method.dart';
import 'package:skin_firts/feature/payment/presentation/pages/payment_summary.dart';
import 'package:skin_firts/feature/settings/presentation/pages/notification.dart';
import 'feature/appointment/presentation/pages/add_review.dart';
import 'feature/appointment/presentation/pages/cancel.dart';
import 'feature/chats/presentation/pages/chat_screen.dart';


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
      home: NotificationScreen(),
    );
  }
}