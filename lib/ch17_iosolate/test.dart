import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

myIsolate(SendPort mainPort) {  //onPress() 함수의 await 구문에서 받는 곳이 이 함수의 매개변수
  ReceivePort isoPort = ReceivePort();  //onPress()의 isoPort에 대응 됨.
  mainPort.send({'port': isoPort.sendPort});  //isoPort.sendPort 객체를 전송
  isoPort.listen((message) {  //Timer.periodic(Duration(seconds: 1), (timer) 함수에서 전송한 메시지 수신
    if (message['msg'] != 'bye') {
      int count = message['msg'];
      mainPort.send({'msg': count * count});   //isoPort로 전송받은 count를 제곱으로 다시 전송
    } else {
      isoPort.close();
    }
  });
}

class MyAppState extends State<MyApp> {
  String result = '';

  void onPress() async  {   //메인 아이솔레이트
    ReceivePort mainPort = ReceivePort();   //아이솔레이트를 구동할려면 ReceivePort를 먼저 만들어야함.
    await Isolate.spawn(myIsolate, mainPort.sendPort);  //spawn()로 아이솔레이트를 구동함. (아이솔레이트 함수, 전달할데이터(또는 sendPort))

    SendPort? isoPort;  //myIsolate에 ReceivePort isoPort에 대응 됨.
    mainPort.listen((message) {   //아이솔레이트에서 데이터를 지속적으로 받으려면 listen 함수를 만듬.
      if (message['port'] != null) {  //isoPort.sendPort를 받아서 동작
        isoPort = message['port'];  //{'port': isoPort.sendPort} 받은 메시지의 isoPort.sendPort를 isoPort에 저장
      } else if (message['msg'] != null) {  //mainPort.send({'msg': count * count});를 통해 전달 받은 메시지에 대응하여 동작
        setState(() {
          result = 'msg : ${message['msg']}';   //받은 메시지의 msg키에 대응되는 값을 result에 저장
        });
      }
    });

    int count = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {   //1초마다 작동하는 함수, isoPort에 메시지를 전송
      count++;
      if (count < 6) {
        isoPort?.send({'msg': count});  //isoPort로 count 전송, 위에 isoPort = message['port']에 저장한 Port로 전송
      } else {
        isoPort?.send({'msg': 'bye'});  //count가 6 이상이면 종료
        mainPort.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Test'),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  result,
                  style: TextStyle(fontSize: 30,),
                ),
                ElevatedButton(
                    onPressed: onPress,
                    child: Text('test1', style: TextStyle(color: Colors.black),),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)))
              ],
            ),
          )),
    );
  }
}
