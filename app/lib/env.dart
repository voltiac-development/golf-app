import 'package:flutter/foundation.dart';
import 'package:flutter_golf/vendor/storage.dart';

class AppUtils {
  static String get apiUrl {
    if (kDebugMode)
      return 'http://localhost:4444/';
    else
      return 'https://golf.voltiac.dev/';
  }

  static bool get development {
    return kDebugMode;
  }

  static Map<String, String> getHeaders() {
    return {
      "GC.AUTH": Storage().getItem('jwt').toString(),
    };
  }
}
