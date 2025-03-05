import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  int calFun(int x) {
    return x * x;
  }

  Stream<int> test() {
    Duration duration = Duration(seconds: 3); //3초
    Stream<int> stream =
    Stream<int>.periodic(duration, calFun); //3초에 한번씩 calFun 호출
    return stream.take(5); //3초에 한번, 최대 5
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
            child: StreamBuilder(stream: test(),  //StreamBuilder 스트림을 받아 화면을 만듬
                //stream 매개변수 : stream 지정
                //builder 매개변수: stream에 지정한 stream에서 데이터가 발생할 때마다 builder 호출
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    //AsyncSnapshot의 connectionState 속성을 이용해서 연결상태를 얻을 수 있다.
                    return Center(
                        child: Text(
                          'completed',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        )
                    );
                  } else
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(),
                          ),
                          Text(
                            'waiting...',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    );
                  }
                  return Center(
                      child: Text(
                        'data :${snapshot.data}',
                        style: TextStyle(
                            fontSize: 30.0
                        ),
                      )
                  );
                }),
          )
      ),
    );
  }
}
