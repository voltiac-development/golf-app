import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/env.dart';
import 'package:golfcaddie/models/livescore.dart';
import 'package:golfcaddie/viewmodels/Friend.dart';

class LiveScoreManager {
  LiveScore model = new LiveScore();

  Future<LiveScore> startSocket(id, context) async {
    this.model.socket = await AppUtils.createSocket(context);
    this.model.socket.emit('join_game', id);
    this.model.socket.on('init', (data) => print(data));

    this.model.socket.emit('update_score', {'roundId': '9e055a93-c756-498c-93f3-d4e470d31c34'});

    this.model.socket.on('update', (data) {
      print(data);
      print('UPDATE RECEIVEID');
    });
    return model;
  }

  Future<Dio> retrieveRoundInformation(id, context) async {
    Dio dio = await AppUtils.getDio();
    Response<dynamic> v = await dio.get('/round/' + id);
    try {
      this.model.players.add(Friend(v.data['playerOne'], v.data['oneHandicap'], v.data['oneId'], '', ''));
    } catch (e) {}
    try {
      this.model.players.add(Friend(v.data['playerTwo'], v.data['twoHandicap'], v.data['twoId'], '', ''));
    } catch (e) {}
    try {
      this.model.players.add(Friend(v.data['playerThree'], v.data['threeHandicap'], v.data['threeId'], '', ''));
    } catch (e) {}
    try {
      this.model.players.add(Friend(v.data['playerFour'], v.data['fourHandicap'], v.data['fourId'], '', ''));
    } catch (e) {}

    return dio;
  }

  Future<LiveScore> retrieveCourseInformation(id, context) async {
    Dio dio = await retrieveRoundInformation(id, context);
    Response<dynamic> courseInformation = await dio.get('/round/' + id);
    dio.get('/course/length/' + courseInformation.data['courseId']).then((value) {
      this.model.white = new List<int>.from(value.data['white']);
      this.model.blue = new List<int>.from(value.data['blue']);
      this.model.yellow = new List<int>.from(value.data['yellow']);
      this.model.red = new List<int>.from(value.data['red']);
      this.model.orange = new List<int>.from(value.data['orange']);
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.response.data['error'],
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    });
    var value = await dio.get('/course/hole/' + courseInformation.data['courseId']).catchError((e) {
      if (e.runtimeType == DioError)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.response.data['error'],
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      else
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Een onverwachte fout is opgetreden.",
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
    });
    for (int i = 0; i < value.data.length; i++) {
      this.model.si[value.data[i]['hole'] - 1] = value.data[i]['si'];
      this.model.par[value.data[i]['hole'] - 1] = value.data[i]['par'];
    }
    return model;
  }
}
