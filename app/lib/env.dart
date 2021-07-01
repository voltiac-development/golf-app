import 'package:flutter/foundation.dart';

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
}
