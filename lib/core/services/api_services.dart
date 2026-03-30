import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:skin_firts/core/API/api_config.dart';

class ApiServices {
  late final Dio _dio;

  ApiServices() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
          // "Accept": "application/json",
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint("DIO_DEBUG: $obj"),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final sessionBox = Hive.box('current_session');
          final token = sessionBox.get('token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },

        onError: (DioException error, handler) {
          if (error.response?.statusCode == 401) {
            debugPrint("Token Expired or Invalid");
            // Clear the invalid token so the app knows the user is no longer authenticated
            Hive.box('current_session').delete('token');
            // Note: You might also want to redirect the user to the Login Screen here
          }
          return handler.next(error);
        },
      ),
    );
  }

  //getting all doctors
  Future<Response?> getDoctor({String? sort, String? gender}) async {
    try {
      final queryParams = <String, dynamic>{};

      if (sort != null && sort.isNotEmpty) {
        queryParams['sort'] = sort;
      }

      if (gender != null && gender.isNotEmpty) {
        queryParams['gender'] = gender;
      }

      final response = await _dio.get('/doctors', queryParameters: queryParams);

      return response;
    } on DioException catch (e) {
      debugPrint("Dio Error Type: ${e.type}");
      debugPrint("Error Message: ${e.message}");
      return e.response;
    }
  }

  Future<Response?> getDoctorAvailability(String id, String dateISO) async {
    if (id.isEmpty) {
      debugPrint("Doctor ID is empty");
      return null;
    }
    try {
      final response = await _dio.get(
        '/doctors/$id/availability',
        queryParameters: {'date': dateISO},
      );

      return response;
    } on DioException catch (e) {
      debugPrint("URL HIT: ${e.requestOptions.uri}");
      // debugPrint("Error fetching doctor availability: ${e.message}");
      return e.response;
    }
  }

  Future<Response?> toggleFavorite(String doctorId) async {
    try {
      final response = await _dio.post(
        '/users/favorites/toggle',
        data: {'doctorId': doctorId},
      );
      return response;
    } on DioException catch (e) {
      debugPrint("Error toggling favorite: ${e.message}");
      return e.response;
    }
  }

  Future<Response?> getAppointments(String status) async {
    try {
      final response = await _dio.get(
        '/appointments',
        queryParameters: {'status': status},
      );
      return response;
    } on DioException catch (e) {
      debugPrint("Error fetching appointments: ${e.message}");
      return e.response;
    }
  }

  //-------------------------------------------------------------------For Appointment Booking---------------------------------------------------------------------------------

  Future<Response?> bookAppointment(Map<String, dynamic> bookingData) async {
    try {
      final response = await _dio.post('/appointments', data: bookingData);
      return response;
    } on DioException catch (e) {
      debugPrint("Error apiServices booking appointment: $e");
      return e.response;
    }
  }

  Future<Response?> cancelAppointment(
    String appointmentId,
    String reason,
  ) async {
    try {
      final response = await _dio.put(
        '/appointments/$appointmentId/cancel',
        data: {'cancelReason': reason},
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> submitReview(Map<String, dynamic> reviewData) async {
    try {
      return await _dio.post('/reviews', data: reviewData);
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> getReviews(String doctorId) async {
    try {
      return await _dio.get('/reviews/doctor/$doctorId');
    } on DioException catch (e) {
      return e.response;
    }
  }
}
