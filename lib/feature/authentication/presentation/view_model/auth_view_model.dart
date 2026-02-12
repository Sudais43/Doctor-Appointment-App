import 'package:flutter/material.dart';
import 'package:skin_firts/feature/authentication/domain/model/user_entity.dart';
import 'package:skin_firts/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:skin_firts/feature/homePage/presentation/pages/home_page.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);

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

    final user = UserEntity(
      userName: "",
      email: trimmedEmail,
      password: trimmedPassword,
    );

    bool isSuccess = await _authRepository.loginUser(user);

    if (!context.mounted) return;

    if (isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
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
    final trimmedUserName = userName.trim();
    final trimmedEmail = email.trim().toLowerCase();
    final trimmedPassword = password.trim();

    final newUser = UserEntity(
      userName: trimmedUserName,
      email: trimmedEmail,
      password: trimmedPassword,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
    );

    if (trimmedUserName.isEmpty ||
        trimmedEmail.isEmpty ||
        trimmedPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Fill the Fields")));
    } else {
      await _authRepository.registerUser(newUser);
      debugPrint("Account Registerd ${newUser.userName}");
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
}
