import 'package:flutter/material.dart';

class OneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('OneScreen'),
            ),
            body: Container(
                color: Colors.red,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OneScreen',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/two');
                      },
                      child: Text('Go two'),
                    ),
                  ],
                )))));
  }
}
