import 'package:dio/dio.dart';
import 'package:skin_firts/feature/authentication/domain/model/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getSavedUser();
  Future<Response?> loginUser(UserEntity user);
  Future<void> registerUser(UserEntity user);
  Future<void> logOut();
}
