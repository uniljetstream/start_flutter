import 'dart:async';

import 'package:flutter/material.dart';


//클래스를 구성할 때 Widget build 함수가 가장 위에 있어야함.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
                  ElevatedButton(
                    onPressed: subscriptionTest,
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    child: Text('subscription',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: controllerTest,
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    child: Text('controller',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: transformerTest,
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    child: Text('transformer',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            )));
  }

  subscriptionTest() {  //StreamSubscription : 스트림 구독자, 스트림을 소비하는 구독자
    var stream = Stream.fromIterable([1, 2, 3]);
    //fromIteralbe() : 주어진 Iterable 객체로부터 비동기적으로 요소를 스트리밍하는 Stream을 생성
    StreamSubscription subscription = stream.listen(null);
    //그냥 일일히 listen 함수에 등록하는 것과 차이점을 모르겠음??
    //스트림 구독자, listen 함수의 매개변수로 별도의 데이터 처리를 명시하지 않겠다는 의미
    subscription.onData((data) {
      print('value : $data');
    });
    subscription.onError((error) {
      print('error : $error');
    });
    subscription.onDone(() {
      print('steam done...');
    });
    //이 외에도 cancel(), pause(), resume() 함수 등 사용 할 수 있다.
  }

  controllerTest() {  //StreamController : 스트림 제어기, 스트림 여러 개를 제어할 수 있다.
    //하나의 스트림 제어기는 하나의 내부 스트림만 가질 수 있으며 스트림 선언 이후에도 스트림 조작 가능
    var controller = StreamController();

    var stream1 = Stream.fromIterable([1, 2, 3]);
    var stream2 = Stream.fromIterable(['A', 'B', 'C']);

    stream1.listen((value) {
      controller.add(value);
    });   //stream1을 controller에 순차적으로 등록
    stream2.listen((value) {
      controller.add(value);  //stream2을 controller에 순차적으로 등록
    });

    controller.stream.listen((value) {
      //stream은 controller의 stream을 말함.(어떤 상속관계인지는 모르겠음)
      print('$value');  //controller에 등록된 stream1, stream2을 받아 출력
    });
  }
  //스트림 제어기에 추가할 수 있는 데이터는 다른 데이터 도 담을 수 있음.
  //controller.add(100);
  //같은 스트림을 두 번 이상 listen()으로 가져오면 오류가 발생하지만 스트림제어기를 이용하면 가능함.

  transformerTest() { //StreamTransformer : 스트림 변환기, 스트림으로 발생한 데이터를 변환하는 역할을 함.
    var stream = Stream.fromIterable([1, 2, 3]);

    StreamTransformer<int, dynamic> transformer =
        StreamTransformer.fromHandlers(handleData: (value, sink) {
      print('in transformer... $value');
      sink.add(value * value);
      //fromHandlers의 두 번째 매개변수를 이용해야 listen까지 이어짐.
    });


    stream.transform(transformer).listen((value) {
      //transform() 매개변수에 등록하여 스트림 변환기(transformer)를 거치게 함.
      print('in listen... $value');
    });
  }
}
