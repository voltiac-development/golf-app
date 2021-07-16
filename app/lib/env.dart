import 'package:flutter/foundation.dart';
import 'package:golfcaddie/vendor/storage.dart';

class AppUtils {
  static String get apiUrl {
    if (kDebugMode)
      return 'https://92c3fdc9cf20.eu.ngrok.io/';
    // return 'https://golf.voltiac.dev/';
    else
      return 'https://golf.voltiac.dev/';
  }

  static bool get development {
    return true;
  }

  static Future<Map<String, String>> getHeaders() async {
    String? item = await new Storage().getItem('jwt');
    return {
      "gc-auth": item ?? "",
    };
  }
}
