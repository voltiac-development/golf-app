import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/env.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

class LiveScoreScreen extends StatefulWidget {
  LiveScoreScreen({Key? key}) : super(key: key);

  @override
  _LiveScoreScreenState createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  String? roundId;
  bool callMade = false;

  _LiveScoreScreenState();
  @override
  Widget build(BuildContext context) {
    if (!callMade) {
      startSocket(ModalRoute.of(context)!.settings.arguments as String);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: DefaultAppBar(
          title: "RONDE " + DateTime.now().day.toString().padLeft(2, '0') + "-" + DateTime.now().month.toString().padLeft(2, '0'), person: true, back: true),
      body: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Center(
            child: !this.callMade
                ? new CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.surface,
                  )
                : Column(children: [Text('callMade')])),
      ),
    );
  }

  void startSocket(id) {
    var socket = io.io(AppUtils.apiUrl, io.OptionBuilder().setTransports(['websocket']).build());
    socket.onConnecting((data) => print(data));
    socket.onConnectError((data) {
      print(data);
      print('connError');
    });
    socket.onConnect((data) {
      print(data);
      print('conn');
    });
    socket.on('reverb', (data) {
      print(data);
      print('reverb');
    });
    socket.onDisconnect((_) => print('disconnect'));
    this.callMade = true;
  }
}
