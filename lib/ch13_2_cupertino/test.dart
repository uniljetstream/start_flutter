import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget platformUI() {
    if (Platform.isIOS) {
      return CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: CupertinoThemeData(brightness: Brightness.light),
          home: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Cupertino Title'),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoButton(
                  onPressed: () {},
                  child: Text('click'),
                ),
                Center(
                  child: Text('HellowWorld'),
                )
              ],
            ),
          ));
    } else if (Platform.isAndroid) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              appBar: AppBar(
                title: Text('Material Title'),
                backgroundColor: Colors.pink,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.black),
                    child: Text('click'),
                  ),
                  Center(
                    child: Text('HelloWorld'),
                  )
                ],
              )));
    } else {
      return Text('unknown Device',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25));
    }
  }

  @override
  Widget build(BuildContext context) {
    return platformUI();
  }
}
