import 'package:flutter/material.dart';

//위젯구조: MyApp-MYInHeriteWidget-TestWidget-TestSubWidget
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Inherited Test'),
            backgroundColor: Colors.blue,
          ),
          body: MyInheritedWidget(TestWidget()),
        ));
  }
}

class MyInheritedWidget extends InheritedWidget {
  int count = 0;

  MyInheritedWidget(child) : super(child: child);

  //여기에 매개변수로 설정하는 위젯이 자신의 하위위젯, 이 위젯부터 그 하위에 있는 모든 위젯이 InheritedWidget의 상태를 이용 할 수 있다.

  increment() {
    //하위에서 호출할 함수
    count++;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) => true;

  //자신이 다시 생성될 때 호출되는 함수, ture면 하위 위젯을 다시 빌드, false면 다시 빌드 하지 않는다.
  //이 함수의 매개변수는 이전 InheritedWidget 객체이며 이전 객체의 값과 현재 자신이 가진 값과 비교해서 true나 false 반환

  static MyInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
}
//of() 함수 : InheritedWidget의 하위 위젯이 InheritedWidget의 객체를 얻으려고 호출하는 함수이다.
//객체를 생성하지 않고 호출해야 하므로 static으로 선언
//dependOnInheritedWidgetOfExactType() : 위젯 계층구조에서 of 함수를 호출한 위젯과 가장가까운 InheritedWidget을 반환

class TestSubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int count = MyInheritedWidget.of(context)!.count;
    return Container(
      width: 200,
      height: 200,
      color: Colors.yellow,
      child: Center(
        child: Text(
          'SubWidget : $count',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

//MyInheritedWidget의 하위 위젯
class TestWidget extends StatelessWidget {
  TestWidge() {
    print('TestWidget constructor..');
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      MyInheritedWidget? widget = MyInheritedWidget.of(context);
      int counter = MyInheritedWidget.of(context)!.count;
      //InheritedWidget의 하위 위젯이 InheritedWidget을 이용하려면 InheritedWidget에서 제공하는 of 함수 사용
      //그러면 위젯 계층구조에 있는 InheritedWidget 객체가 전달되므로 이 객체를 이용해 필요한 데이터나 함수를 이용하면 된다.

      Function increment = MyInheritedWidget.of(context)!.increment;
      return Center(
          child: Container(
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('TestWidget : $counter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      child: Text(
                        'increment()',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => setState(() => increment()),
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blue))),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => widget!.count++);
                    },
                    child:
                        Text('count++', style: TextStyle(color: Colors.black)),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  ),
                  TestSubWidget()
                ],
              )));
    });
  }
}
