import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthServices {
  final Dio _dio = Dio(
    BaseOptions(
      // IMPORTANT: 10.0.2.2 only works for the Android Emulator.
      // For physical devices, use your computer's IP (e.g., 192.168.x.x).
      // For iOS Simulator, use localhost.
      baseUrl: "http://10.0.2.2:3000/api/auth",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );

  Future<Response?> signUp(String name, String email, String password) async {
    try {
      final response = await _dio.post(
        '/signup',
        data: {'fullName': name, 'email': email, 'password': password},
      );
      return response;
    } on DioException catch (e) {
      debugPrint("SignUp Dio Error Type: ${e.type}");
      debugPrint("SignUp Error Message: ${e.message}");
      if (e.response != null) {
        debugPrint("SignUp Server Response Data: ${e.response?.data}");
      }
      return e.response;
    }
  }

  Future<Response?> logIn(String email, String password) async {
    try {
      return await _dio.post(
        '/signin',
        data: {'email': email, 'password': password},
      );
    } on DioException catch (e) {
      return e.response;
    }
  }
}
