import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:golfcaddie/components/friends/requestRow.dart';
import 'package:golfcaddie/env.dart';
import 'package:golfcaddie/models/Friend.dart';

import 'package:http/http.dart' as http;

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
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: this.errorValue == '' ? 0 : 30,
                child: Text(
                  this.errorValue,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.normal),
                ),
              ),
              Text(
                this.requests.length == 0
                    ? 'Er zijn geen inkomende verzoeken.'
                    : this.requests.length.toString(),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
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
    http.post(Uri.parse(AppUtils.apiUrl + "friend/decline"),
        headers: await AppUtils.getHeaders(),
        body: {"friendId": request}).then((value) {
      Map<String, dynamic> response = jsonDecode(value.body);
      if (response['error'] == null) {
        getsRequests();
      }
    });
  }

  void acceptRequest(request) async {
    Map<String, String> headers = await AppUtils.getHeaders();
    http.post(Uri.parse(AppUtils.apiUrl + "friend/accept"),
        headers: headers, body: {"friendId": request}).then((value) {
      Map<String, dynamic> response = jsonDecode(value.body);
      if (response['error'] == null) {
        getsRequests();
      }
    });
  }

  void getsRequests() async {
    this.requests = [];
    http
        .get(Uri.parse(AppUtils.apiUrl + "friend/incoming"),
            headers: await AppUtils.getHeaders())
        .then((value) {
      Map<String, dynamic> response = jsonDecode(value.body);
      if (response['error'] == null) {
        List<dynamic>.from(response['requests']).forEach((e) {
          this.requests.add(UserRequest(e['name'], e['email'], e['id']));
        });
        if (this.mounted) setState(() {});
      }
    });
  }
}
