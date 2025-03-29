import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//메시시 채널 이용 방법
//android/app/src/main/kotlin/MainActivity
//ios/Runner/AppDelegate.swift    mac에서만 실행 가능해서 안함.
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Channel',
      theme: ThemeData(
        primaryColor: Colors.blue,
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
    const channel =
        BasicMessageChannel<String>('myMessageChannel', StringCodec()); //채널 생성
    String? result = await channel.send('Hello from Dart');
    setState(() {
      resultMessage = result;
    });
    channel.setMessageHandler((String? message) async { //매개변수는 데이터가 전달 될때 호출될 함수
      setState(() {
        receiveMessage = message;
      });
      return 'Reply from Dart';   //반환값은 다시 네이티브보냄.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Channel'),
      ),
      body: Container(
        color: Colors.deepPurpleAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (<Widget>[
              Text('resultMessage : $resultMessage'),
              Text('receive Message : $receiveMessage'),
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
