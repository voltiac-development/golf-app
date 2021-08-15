import 'package:localstorage/localstorage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../env.dart';

class Storage {
  Future<dynamic> getItem(String item) async {
    if (!AppUtils.development) {
      final FlutterSecureStorage storage = new FlutterSecureStorage();
      return storage.read(key: 'caddie_' + item);
    } else {
      final LocalStorage storage = new LocalStorage('golfcaddie');
      await storage.ready;
      return storage.getItem(item);
    }
  }

  Future<void> setItem(String item, String value) async {
    if (!AppUtils.development)
      await new FlutterSecureStorage().write(key: "caddie_" + item, value: value);
    else {
      final LocalStorage storage = new LocalStorage('golfcaddie');
      await storage.ready;
      storage.setItem(item, value);
    }
  }

  Future<void> delItem(String item) async {
    if (!AppUtils.development)
      await new FlutterSecureStorage().delete(key: "caddie_" + item);
    else {
      final LocalStorage storage = new LocalStorage('golfcaddie');
      await storage.ready;
      storage.deleteItem(item);
    }
  }
}
