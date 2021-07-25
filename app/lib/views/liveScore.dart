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
                : Column(children: [
                    TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(Icons.directions_car_outlined),
                        ),
                        Tab(
                          icon: Icon(Icons.directions_transit_outlined),
                        ),
                        Tab(
                          icon: Icon(Icons.directions_bike_outlined),
                        )
                      ],
                    ),
                    TabBarView(
                      children: [Icon(Icons.directions_car_outlined), Icon(Icons.directions_transit_outlined), Icon(Icons.directions_bike_outlined)],
                    ),
                    Row(
                      children: [],
                    )
                  ])),
      ),
    );
  }

  void startSocket(id) async {
    print(id);
    io.Socket socket = await AppUtils.createSocket(context);
    socket.emit('join_game', id);
    this.callMade = true;

    socket.emit('update_score', {'roundId': '9e055a93-c756-498c-93f3-d4e470d31c34'});

    socket.on('update', (data) {
      print(data);
      print('UPDATE RECEIVEID');
    });
    setState(() {});
  }
}
