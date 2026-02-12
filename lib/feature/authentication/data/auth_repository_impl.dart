import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:skin_firts/core/services/hive_auth_services.dart';
import 'package:skin_firts/feature/authentication/domain/model/user_entity.dart';
import 'package:skin_firts/feature/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final HiveAuthServices localAuthServices;

  AuthRepositoryImpl({required this.localAuthServices});

  @override
  Future<UserEntity?> getSavedUser() async {
    final userData = localAuthServices.getUser();

    if (userData == null) return null;

    return UserEntity(
      userName: userData['userName'],
      email: userData['email'],
      password: userData['password'],
    );
  }

  @override
  Future<void> registerUser(UserEntity user) async {
    final userMap = {
      'userName': user.userName,
      'email': user.email,
      'password': user.password,
      'phoneNumber': user.phoneNumber,
      'dateOfBirth': user.dateOfBirth,
    };

    final box = Hive.box('auth_box');
    await box.put(user.email, userMap);
    await localAuthServices.saveUser(userMap);
  }

  @override
  Future<bool> loginUser(UserEntity user) async {
    final box = Hive.box('auth_box');

    final savedUser = box.get(user.email);

    if (savedUser != null &&
        savedUser is Map &&
        savedUser['password'] == user.password) {
      await localAuthServices.saveUser(Map<String, dynamic>.from(savedUser));
      return true;
    }

    return false;
  }

  @override
  Future<void> logOut() async {
    await localAuthServices.removeUser();
  }
}
