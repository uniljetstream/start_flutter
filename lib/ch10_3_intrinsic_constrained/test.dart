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
              title: Text('Test'),
              backgroundColor: Colors.yellow,
            ),
            body: Column(
              children: [
                IntrinsicWidth(    //red, green, blue가 stretch가 작동하여 넓이가 같게됨
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        color: Colors.red,
                        width: 50,
                        height: 50.0,
                      ),
                      Container(
                        color: Colors.green,
                        width: 150.0,
                        height: 150.0,
                      ),
                      Container(
                        color: Colors.blue,
                        width: 100,
                        height: 100.0,
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(  //최소 폭, 최대 길이 결정
                    minWidth: 300,
                    maxHeight: 50
                  ),
                  child:
                      Container(color: Colors.amber, width: 150, height: 150.0),
                )
              ],
            )));
  }
}
