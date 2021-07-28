import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../components/appbar.dart';
import '../env.dart';
import '../vendor/storage.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordControllerVerify = TextEditingController();
  final nameController = TextEditingController();
  String favCourse = "";
  String? errorHint;
  List<dynamic> courses = [];

  LoginState({Key? key}) {
    retrieveCourses();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = OutlinedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      primary: Colors.white,
    );

    return Scaffold(
      appBar: DefaultAppBar(
        title: 'REGISTEREN',
        person: false,
        back: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFffffff), borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: max(250, MediaQuery.of(context).size.width * 0.50),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Voor en achternaam',
                    icon: Icon(Icons.person_outline),
                    contentPadding: EdgeInsets.all(8),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(),
                  ),
                )),
            SizedBox(height: 10),
            SizedBox(
                width: max(250, MediaQuery.of(context).size.width * 0.50),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'E-mail',
                    icon: Icon(Icons.mail_outline),
                    contentPadding: EdgeInsets.all(8),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(),
                  ),
                )),
            SizedBox(height: 10, width: MediaQuery.of(context).size.width),
            SizedBox(
                width: max(250, MediaQuery.of(context).size.width * 0.50),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Wachtwoord',
                    icon: Icon(Icons.lock_outline),
                    contentPadding: EdgeInsets.all(8),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(),
                  ),
                  autocorrect: false,
                  obscureText: true,
                )),
            SizedBox(height: 10),
            SizedBox(
                width: max(250, MediaQuery.of(context).size.width * 0.50),
                child: TextField(
                  controller: passwordControllerVerify,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Wachtwoord controleren',
                    icon: Icon(Icons.lock_outline),
                    contentPadding: EdgeInsets.all(8),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(),
                  ),
                  autocorrect: false,
                  obscureText: true,
                )),
            SizedBox(height: 10),
            SizedBox(
                width: max(250, MediaQuery.of(context).size.width * 0.50),
                child: DropdownButtonFormField(
                  isDense: true,
                  items: courses.map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value['id'],
                      child: Text(
                        value['name'],
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    // do other stuff with _category
                  },
                  value: favCourse,
                  decoration: InputDecoration(
                    isDense: true,
                    focusColor: Theme.of(context).primaryColor,
                    contentPadding: EdgeInsets.all(8),
                    icon: Icon(Icons.track_changes),
                    border: new OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2, style: BorderStyle.solid)),
                    filled: false,
                  ),
                )),
            SizedBox(height: 10),
            ElevatedButton(
              style: style,
              onPressed: () {
                checkRegister(context);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Text('Registreren'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkRegister(final context) async {
    Dio dio = await AppUtils.getDio();
    dio.post('/auth/register', data: {
      'email': emailController.text,
      'password': passwordController.text,
      'name': nameController.text,
      'password_verify': passwordControllerVerify.text,
      'fav_course': favCourse
    }).then((value) async {
      Storage().setItem('jwt', value.data['jwtToken']);
      Navigator.of(context).pushNamed('dashboard');
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.response.data['error'],
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    });
  }

  void retrieveCourses() async {
    Dio dio = await AppUtils.getDio();
    dio.get('/course/all').then((value) {
      this.favCourse = value.data['courses'][0]['id'];
      setState(() {
        this.courses = value.data['courses'];
      });
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.response.data['error'],
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    });
  }
}
