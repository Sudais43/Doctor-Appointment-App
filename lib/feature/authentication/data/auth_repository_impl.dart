import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:skin_firts/core/services/hive_auth_services.dart';
import 'package:skin_firts/feature/authentication/domain/model/user_entity.dart';
import 'package:skin_firts/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:skin_firts/services/auth_services.dart';

class AuthRepositoryImpl extends AuthRepository {
  final HiveAuthServices localAuthServices;
  final AuthServices apiServices;

  AuthRepositoryImpl({
    required this.localAuthServices,
    required this.apiServices,
  });

  @override
  Future<UserEntity?> getSavedUser() async {
    final userData = localAuthServices.getUser();

    if (userData == null) return null;

    return UserEntity(
      fullName: userData['userName'],
      email: userData['email'],
      password: userData['password'],
    );
  }

  @override
  Future<Response?> registerUser(UserEntity user) async {
    final response = await apiServices.signUp(
      user.fullName,
      user.email,
      user.password,
    );

    if (response != null && response.statusCode == 201) {
      final userMap = {
        'userName': user.fullName,
        'email': user.email,
        'password': user.password,
        'phoneNumber': user.phoneNumber,
        'dateOfBirth': user.dateOfBirth,
      };

      final box = Hive.box('auth_box');
      await box.put(user.email, userMap);
      await localAuthServices.saveUser(userMap);
    }
    return response;
  }

  @override
  Future<Response?> loginUser(UserEntity user) async {
    final response = await apiServices.logIn(user.email, user.password);

    if (response != null && response.statusCode == 200) {
      final token = response.data['token'];
      final userData = response.data['users'];

      await localAuthServices.saveUser({
        'userName': userData['fullName'],
        'email': userData['email'],
        'token': token,
      });

      final sessionBox = Hive.box('current_session');
      await sessionBox.put('isLoggedIn', true);
    }
    return response;

    // final box = Hive.box('auth_box');

    // final savedUser = box.get(user.email);

    // if (savedUser != null &&
    //     savedUser is Map &&
    //     savedUser['password'] == user.password) {
    //   await localAuthServices.saveUser(Map<String, dynamic>.from(savedUser));
    //   return true;
    // }

    // return false;
  }

  @override
  Future<void> logOut() async {
    await localAuthServices.removeUser();
    final sessionBox = Hive.box('current_session');
    await sessionBox.clear();
  }
}
