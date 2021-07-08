import 'package:localstorage/localstorage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../env.dart';

class Storage {
  Future<String?> getItem(String item) async {
    if (!AppUtils.development)
      return new FlutterSecureStorage().read(key: 'caddie_' + item).toString();
    else {
      final LocalStorage storage = new LocalStorage('golfcaddie');
      await storage.ready;
      return storage.getItem(item).toString();
    }
  }

  Future<void> setItem(String item, String value) async {
    if (!AppUtils.development)
      await new FlutterSecureStorage()
          .write(key: "caddie_" + item, value: value);
    else {
      final LocalStorage storage = new LocalStorage('golfcaddie');
      await storage.ready;
      storage.setItem(item, value);
    }
  }
}
