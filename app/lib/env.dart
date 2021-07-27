import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/vendor/storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

class AppUtils {
  static String get apiUrl {
    if (kDebugMode)
      return 'http://192.168.178.87:4444/';
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

  static Future<io.Socket> createSocket(BuildContext context) async {
    Map<String, String> headers = await getHeaders();
    io.Socket socket = io.io(apiUrl, io.OptionBuilder().setTransports(['websocket']).setAuth(headers).setReconnectionAttempts(2).build());
    socket.onConnectError((data) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Er is een probleem met de verbinding.',
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        )));
    socket.onConnect((data) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Verbonden met de server.',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        )));
    return socket;
  }
}
