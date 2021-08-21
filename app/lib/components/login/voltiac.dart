import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/env.dart';
import 'package:url_launcher/url_launcher.dart';

class VoltiacLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "log-in met: ",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
        GestureDetector(
          onTap: () {
            goToVoltiac(context);
          },
          child: Container(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Image.network(
                  'https://cdn.bartverm.dev/voltiac/transparentBlack.png',
                  height: 30,
                  width: 55,
                ),
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.primary), borderRadius: BorderRadius.all(Radius.circular(25)), color: Colors.white),
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 10, offset: Offset.fromDirection(10)),
              ],
            ),
          ),
        )
      ],
    );
  }

  void goToVoltiac(context) async {
    if (await canLaunch('https://portal.voltiac.dev')) {
      await launch('https://portal.voltiac.dev');
    } else {
      AppUtils.callSnackbar(context, "De website \"https://portal.voltiac.dev\" kan niet geopend worden.");
    }
  }
}
