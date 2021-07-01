import 'package:localstorage/localstorage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../env.dart';

class Storage {
  String? getItem(String item) {
    if (!AppUtils.development)
      return new FlutterSecureStorage().read(key: 'caddie_' + item).toString();
    else
      return new LocalStorage('golfcaddie').getItem(item);
  }

  void setItem(String item, String value) async {
    if (!AppUtils.development)
      await new FlutterSecureStorage()
          .write(key: "caddie_" + item, value: value);
    else {
      new LocalStorage('golfcaddie').setItem(item, value);
    }
  }
}
