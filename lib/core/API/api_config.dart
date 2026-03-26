import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiConfig {
  static String get baseUrl {
    if (kReleaseMode) {
      return "";
    }
    if (Platform.isAndroid) {
      return "http://10.0.2.2:3000/api";
    }
    if (Platform.isIOS) {
      return "http://localhost:3000/api";
    }

    return "http://192.168.201.102:3000/api";
  }
}
