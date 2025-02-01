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
              backgroundColor: Colors.blue, //넣고 싶어서 넣음
            ),
            body: Column(
              children: [
                Image(
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                ),
                Container(
                  color: Colors.red,
                  child: Image.asset(
                    'images_9_3/big.jpeg',
                    width: 200,
                    height: 100,
                    //fit: BoxFit.contain,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            )));
  }
}
