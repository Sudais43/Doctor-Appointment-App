import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:skin_firts/feature/authentication/domain/model/user_entity.dart';
import 'package:skin_firts/main_screen.dart';
import 'package:skin_firts/services/auth_services.dart';

class AuthViewModel extends ChangeNotifier {
  // final AuthRepository _authRepository;
  final AuthServices _authServices;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthViewModel(
    // this._authRepository,
    this._authServices,
  );

  Future<void> signIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    final trimmedEmail = email.trim().toLowerCase();
    final trimmedPassword = password.trim();

    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Fill the Fields")));
      return;
    }

    try {
      final response = await _authServices.logIn(trimmedEmail, trimmedPassword);
      if (response != null && response.statusCode == 200) {
        final token = response.data['token'];
        final userData = response.data['user'];

        debugPrint("Login SuccessFul: ${userData['fullName']}");

        final sessionBox = Hive.box('current_session');
        await sessionBox.put('isLoggedIn', true);

        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Welcome Back $userData['fullName']"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (route) => false,
        );
      } else {
        if (!context.mounted) return;
        String errorMsg =
            response?.data['message'] ?? "Login failed. Try again.";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      debugPrint("Connection Error. Try again. $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Connection Error. Try again. $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> signUp({
    required String userName,
    required String email,
    required String password,
    String? phoneNumber,
    String? dateOfBirth,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final trimmedUserName = userName.trim();
    final trimmedEmail = email.trim().toLowerCase();
    final trimmedPassword = password.trim();

    final newUser = UserEntity(
      fullName: trimmedUserName,
      email: trimmedEmail,
      password: trimmedPassword,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
    );

    try {
      final response = await _authServices.signUp(
        newUser.fullName,
        newUser.email,
        newUser.password,
      );

      if (response != null &&
          (response.statusCode == 201 || response.statusCode == 200)) {
        debugPrint("Account Registerd ${newUser.fullName}");

        final sessionBox = Hive.box('current_session');
        await sessionBox.put('isLoggedIn', true);

        if (!context.mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Account Created")));

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (route) => false,
        );
      } else {
        if (!context.mounted) return;
        String errorMsg =
            response?.data['message'] ?? "Registration failed. Try again.";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration failed. Try again. $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
