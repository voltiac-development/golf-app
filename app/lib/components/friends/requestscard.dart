import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/friends/requestRow.dart';
import 'package:golfcaddie/env.dart';
import 'package:golfcaddie/models/Friend.dart';

class RequestsCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RequestsCardState();
}

class RequestsCardState extends State<RequestsCard> {
  String errorValue = "";
  List<UserRequest> requests = [];

  RequestsCardState() {
    getsRequests();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: 300,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  'Vriend verzoeken',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: this.errorValue == '' ? 0 : 30,
                child: Text(
                  this.errorValue,
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.normal),
                ),
              ),
              Text(
                this.requests.length == 0 ? 'Er zijn geen inkomende verzoeken.' : this.requests.length.toString(),
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              ...requests
                  .map((item) => new RequestRow(
                        name: item.name,
                        email: item.email,
                        onDecline: (value) => declineRequest(item.id),
                        onAccept: (value) => acceptRequest(item.id),
                      ))
                  .toList(),
            ],
          ),
        ));
  }

  void declineRequest(request) async {
    Dio dio = await AppUtils.getDio();
    dio.post('/friend/decline', data: {"friendId": request}).then((value) {
      getsRequests();
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.response.data),
        backgroundColor: Colors.red,
      ));
    });
  }

  void acceptRequest(request) async {
    Dio dio = await AppUtils.getDio();
    dio.post('/friend/accept', data: {"friendId": request}).then((value) {
      getsRequests();
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.response.data),
        backgroundColor: Colors.red,
      ));
    });
  }

  void getsRequests() async {
    Dio dio = await AppUtils.getDio();
    this.requests = [];
    dio.get('/friend/incoming').then((value) {
      if (value.data['error'] == null) {
        List<dynamic>.from(value.data['requests']).forEach((e) {
          this.requests.add(UserRequest(e['name'], e['email'], e['id']));
        });
        if (this.mounted) setState(() {});
      }
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.response.data),
        backgroundColor: Colors.red,
      ));
    });
  }
}
