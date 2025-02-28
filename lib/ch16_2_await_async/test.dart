import 'dart:async';

import 'package:flutter/material.dart';

/*
Future클래스의 문제점 : 받환 받은 객체가 Future객체라 실제 발생한 데이터가 아니다.
즉 실제 데이터를 받을면 콜백함수를 등록하고 데이터가 발생한 시점에 그 함수가 전달하도록 해주어야한다. ==> then() 함수 이
 */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<int> funA() {  //3초 지연 후 10을 리턴하는 함수
    return Future.delayed(Duration(seconds: 3), () {
      return 10;
    });
  }

  Future<int> funB(int arg) {   //2초 지연 후 arg*arg를 리턴하는 함수.
    return Future.delayed(Duration(seconds: 2), () {
      return arg * arg;
    });
  }

  Future<int> calFun() async { //funA()와 funB()의 결과를 받는 함수
    //await는 실행영역에 작성하고 async는 선언영역에 작성한다.
    //await : 한 작업의 처리결과를 받아 다음 작업을 처리할 때 앞선 작업의 처리가 끝낼때 까지 대기시키는 용도
    //await는 꼭 async로 선언한 영역에 있어야 함. 즉 await를 사용하려면 꼭 async를 꼭 사용해야한다.
    int aResult = await funA();   //funA()에서 실제 데이터가 반환될 때까지 대기함. funA()의 반환값을 Future를 사용하지 않고 실제 발생한 데이터 타입으로 받을 수 있다.
    int bResult = await funB(aResult);  //funB(aResult)를 호춯하고 대기 했다가 최종값으로 반환
    return bResult;
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
                child: FutureBuilder(
                    future: calFun(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                            child: Text(
                          '${snapshot.data}', //Future의 반환값을 저장하는 변수 = snapshot
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ));
                      }
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            )
                          ],
                        ),
                      );
                    }))));
  }
}

/*
then()
: future에 데이터가 담기는 순간 콜백함수를 호출 할 수 있게함.
catchError()
: future를 반환한 곳에서 발생한 오류를 처리할 수 있게함.

그런데 then()을 사용하면 코드가 복잡해 진다.그래서 사용하는 것이 await와 async이다.
 */
