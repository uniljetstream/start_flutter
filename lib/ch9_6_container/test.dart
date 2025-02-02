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
        backgroundColor: Colors.blue,
      ),
      body: Container(
          height: Size.infinite.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red,
                Colors.yellow,
              ],
            ),
          ),
          child: Center(
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('images_9_3/big.jpeg'), fit: BoxFit.cover),
              ),
              width: 200,
              height: 200,
            ),
          )),
    ));
  }
}
