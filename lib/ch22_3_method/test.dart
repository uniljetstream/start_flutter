import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//android/app/src/main/kotlin/MainActivity.kt
//메서드 채널
//네이티브 메서드를 호출하는 것이 아니라 메서드 이름을 식별자로 정하고 그 이름의 메서드로 데이터를 주고 받는 방식
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Channel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NativeCallWidget(),
    );
  }
}

class NativeCallWidget extends StatefulWidget {
  @override
  NativeCallWidgetState createState() => NativeCallWidgetState();
}

class NativeCallWidgetState extends State<NativeCallWidget> {
  String? resultMessage;
  String? receiveMessage;

  Future<Null> nativeCall() async {
    const channel = const MethodChannel('myMethodChannel');

    try {
      var details = {'Username': 'kkang', 'Password': '1234'};
      final Map result = await channel.invokeMethod("oneMethod", details);
      setState(() {
        resultMessage = "${result["one"]}, ${result["two"]}";
      });
      channel.setMethodCallHandler((call) async {
        switch (call.method) {
          case 'twoMethod':
            setState(() {
              receiveMessage = "receive : ${call.arguments}";
            });
            return 'Reply from Dart';
        }
      });
    } on PlatformException catch (e) {
      print("Failed : '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Method Channel"),
      ),
      body: Container(
        color: Colors.deepPurpleAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (<Widget>[
              Text(
                'resultMessage : $resultMessage',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                'receiveMessage : $receiveMessage',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              ElevatedButton(
                  onPressed: () {
                    nativeCall();
                  },
                  child: Text('native call'))
            ]),
          ),
        ),
      ),
    );
  }
}
