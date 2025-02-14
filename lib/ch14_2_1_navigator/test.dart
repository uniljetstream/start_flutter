import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _isDeepLink = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator Test',
      home: Navigator(pages: [
        MaterialPage(child: OneScreen()),
        if (_isDeepLink) MaterialPage(child: TwoScreen())
      ], onPopPage: (route, result) => route.didPop(result)),
      );
      //onPopPage는 사용권장하는 함수가 아님. 그런데 대체 함수인 onDidRemovePage를 사용하는 법을 모르겟음.
  }
}

class OneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OneScreen'),
      ),
      body: Container(
          color: Colors.red,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('OneScreen',
                  style: TextStyle(color: Colors.white, fontSize: 30))
            ],
          ))),
    );
  }
}

class TwoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TwoScreen'),
      ),
      body: Container(
        color: Colors.cyan,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('TwoScreen', style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text('Pop')),
            ],
          ),
        )
      )
    );
  }
}
