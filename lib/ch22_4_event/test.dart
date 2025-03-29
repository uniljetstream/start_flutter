/*
다른 채널과 다르게 네이티브에서 다트를 실행하는 방법으로만 사용한다.
다른 채널과 차이가 있다면 이벤트를 등록하고 그 이벤트로 발생하는 데이터를 반복해서 받을 때 사용.
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  String? receiveMessage;

  Future<Null> nativeCall() async {
    const channel = EventChannel('eventChannel');
    channel.receiveBroadcastStream().listen((dynamic event) {   //데이터 받기
      setState(() {
        receiveMessage = 'Received event : $event';
      });
    }, onError: (dynamic error) {
      print('Received error : ${error.message}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Event Channel"),
        ),
        body: Container(
          color: Colors.deepPurpleAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (<Widget>[
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
        ));
  }
}
