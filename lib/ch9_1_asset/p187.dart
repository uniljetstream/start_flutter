import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Text'),
          ),
          body: Column(children: [
            //Image.asset('images/icon1.png'),
          ],)
        )
      );
  }
}