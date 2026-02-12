import 'package:hive_ce/hive.dart';

class HiveAuthServices {
  final _box = Hive.box('auth_box');

  static const String user_key = 'current_user';

  Future<void> saveUser(Map<String, dynamic> userData) async {
    await _box.put(user_key, userData);
  }

  Map<String, dynamic>? getUser() {
    final data = _box.get('current_user');
    return data != null ? Map<String, dynamic>.from(data as Map) : null;
  }

  Future<void> removeUser() async {
    await _box.delete(user_key);
  }
}
