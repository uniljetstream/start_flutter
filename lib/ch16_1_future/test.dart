/* Future 클래스(p415)
시간이 올래 걸리는 부분에서 미래의 데이터를 담을 수 있는 Future 상자를 만들어 다른 작업을
함께 실행하고 실제 데이터가 발생하는 시점에 Future에 담아 이용 할 수 있게 하는 것입니다.
 */

import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<int> sum() { //제네릭을 이용 반환 받을 데이터 타입 선언. 이 함수에서 반환받는 값이 Future에 담기는 미래 데이터이다.
    return Future<int>(() {   //미래의 데이터를 담을 상자 반환
      var sum = 0;
      for (int i = 0; i < 50000000; i++) {
        sum += i;
      }
      return sum;   //실제 데이터를 상자에 담
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
            body: FutureBuilder(    //결과가 나올 때까지 대기했다가 화면에 출력해 주는 위젯
              //futurebuilder는 위젯이지만 자체 화면이 없음. builder 속성으로 지정.
                future: sum(),
                builder: (context, snapshot) {  //context, snapshot은 매개변수.
                  //builder 속성의 타입은 AsyncWidgetBuilder 함수
                  //두번째 매개변수 snapshot의 타입은 AsyncSnapshot<T> 이곳에 Future 데이터를 전달.
                  if (snapshot.hasData) { //hasData() : AsyncSnapShot 객체의 속성으로 데이터가 있는지 판단.
                    return Center(  //데이터가 있으면 반환하는 위젯. sum() 결과를 보여줌.
                      child: Text(
                        '${snapshot.data}',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    );
                  }
                  return Center(  //데이터가 없으면 반환하는 위젯.
                    child: Text(
                      'waiting',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  );
                })));
  }
}
