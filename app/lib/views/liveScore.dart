import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/components/score/table.dart';
import 'package:golfcaddie/components/score/tableHeader.dart';
import 'package:golfcaddie/env.dart';
import 'package:golfcaddie/models/Friend.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class LiveScoreScreen extends StatefulWidget {
  LiveScoreScreen({Key? key}) : super(key: key);

  @override
  _LiveScoreScreenState createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  String? roundId;
  bool callMade = false;
  List<Friend> players = [
    Friend('Bart Vermeulen', 39.9, '', ''),
    Friend('Maartje Vermeulen', 39.9, '', ''),
    Friend('Olivier Boekestijn', 39.9, '', ''),
    Friend('Godelieve Boekestijn', 39.9, '', ''),
  ];
  List<IconData> icons = [Icons.looks_one_outlined, Icons.looks_two_outlined, Icons.looks_3_outlined, Icons.looks_4_outlined];

  _LiveScoreScreenState();
  @override
  Widget build(BuildContext context) {
    if (!callMade) {
      startSocket(ModalRoute.of(context)!.settings.arguments as String);
    }
    return DefaultTabController(
        length: players.length + 1,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          appBar: DefaultAppBar(
              title: "RONDE " + DateTime.now().day.toString().padLeft(2, '0') + "-" + DateTime.now().month.toString().padLeft(2, '0'), person: true, back: true),
          body: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                child: Center(
                    child: !this.callMade
                        ? new CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.surface,
                          )
                        : Column(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: TabBar(
                                      isScrollable: true,
                                      indicatorColor: Theme.of(context).colorScheme.surface,
                                      tabs: [
                                        for (int i = 0; i < players.length; i++)
                                          Tab(
                                              child: Text(
                                                players[i].name.split(' ')[0],
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              icon: Icon(
                                                icons[i],
                                                color: Colors.black,
                                              )),
                                        Tab(
                                            // child: Text(
                                            //   "",
                                            //   style: TextStyle(color: Colors.black),
                                            // ),
                                            icon: Icon(
                                          Icons.navigate_next_outlined,
                                          color: Colors.black,
                                        )),
                                      ],
                                    ),
                                  )),
                              TableHeader(),
                              Expanded(
                                child: TabBarView(children: [
                                  for (int i = 0; i < players.length; i++)
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 15, bottom: 15),
                                        child: ScoreTable(),
                                      ),
                                    ),
                                  SizedBox(
                                      height: 50,
                                      width: 250,
                                      child: ElevatedButton(
                                          onPressed: () => print('pressed'),
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text('Score versturen'),
                                          )))
                                ]),
                              )
                            ],
                          )),
              )),
        ));
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
