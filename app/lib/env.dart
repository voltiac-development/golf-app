import 'package:flutter/foundation.dart';
import 'package:flutter_golf/vendor/storage.dart';

class AppUtils {
  static String get apiUrl {
    if (kDebugMode)
      return 'http://196fed92f1c9.eu.ngrok.io/';
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
