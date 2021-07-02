import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ButtonStyle style = OutlinedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 16),
    backgroundColor: Colors.white,
    primary: Colors.black,
    fixedSize: Size(125, 10),
    alignment: Alignment.center);

class PopupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profile_edit',
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin!, end: end!);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).accentColor,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Test1()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromLTRB(
      lerpDouble(begin!.left, end!.left, elasticCurveValue) ?? 0.0,
      lerpDouble(begin!.top, end!.top, elasticCurveValue) ?? 0.0,
      lerpDouble(begin!.right, end!.right, elasticCurveValue) ?? 0.0,
      lerpDouble(begin!.bottom, end!.bottom, elasticCurveValue) ?? 0.0,
    );
  }
}

class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 300,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Theme.of(context).accentColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  'Profiel aanpassen',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                  width: max(250, MediaQuery.of(context).size.width * 0.50),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: 'Naam',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white,
                    ),
                    autocorrect: false,
                    obscureText: false,
                    cursorColor: Colors.white,
                  )),
              SizedBox(height: 10),
              SizedBox(
                  width: max(250, MediaQuery.of(context).size.width * 0.50),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: 'E-mail',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.mail_outline_outlined,
                        color: Colors.white,
                      ),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white,
                    ),
                    autocorrect: false,
                    obscureText: false,
                    cursorColor: Colors.white,
                  )),
              SizedBox(height: 10),
              SizedBox(
                  width: max(250, MediaQuery.of(context).size.width * 0.50),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: 'Wachtwoord',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white,
                    ),
                    autocorrect: false,
                    obscureText: true,
                    cursorColor: Colors.white,
                  )),
              SizedBox(height: 10),
              SizedBox(
                  width: max(250, MediaQuery.of(context).size.width * 0.50),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: 'Nieuw wachtwoord',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white,
                    ),
                    autocorrect: false,
                    obscureText: true,
                    cursorColor: Colors.white,
                  )),
              SizedBox(height: 20),
              OutlinedButton.icon(
                style: style,
                icon: Icon(Icons.save_alt_outlined),
                label: Text(
                  'Bijwerken',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {},
              ),
            ],
          )),
    );
  }
}
