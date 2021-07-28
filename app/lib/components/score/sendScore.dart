import 'package:flutter/material.dart';

class SendScoreView extends StatelessWidget {
  const SendScoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.secondary),
            onPressed: () => print('pressed'),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Score versturen'),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(Icons.send_outlined)
                  ],
                ),
              ),
            )),
      ),
    ));
  }
}
