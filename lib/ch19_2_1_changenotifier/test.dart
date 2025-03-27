import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  //변경된 상태를 하위 위젯에 적용하는 ChangeNotifierProvider
  //ChangeNotifier를 통해 구현, 따라서 int등 기초 타입의 상태는 등록할 수 없다.
  int _count = 0;

  int get count => _count;

  void increment() {
    //increament() 함수를 호출하여 상태 데이터를 변경한다고 가정.
    _count++;
    notifyListeners();
    //상태 데이터가 변화되었다고 하위 위젯을 다시 빌드하지는 않고 notifyListeners()함수를 호출해야 한다.
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('ChangeNotifierProvider Test'),
            backgroundColor: Colors.blue,
          ),
          body: ChangeNotifierProvider<Counter>.value(
            //상태 등록
            value: Counter(),
            child: SubWidget(),
            //ChangeNotifierProvider는 자신에게 등록된 모델 클래스에서 notifyListeners()함수 호출을 감지해 child에 등록된 위젯을 다시 빌드해준다.
          )),
    );
  }
}

class SubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<Counter>(context); //Counter 가져오기
    return Container(
        color: Colors.orange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Provider count : ${counter.count}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              ElevatedButton(
                  onPressed: () {
                    counter.increment();
                  },
                  child: Text('increment')),
            ],
          ),
        ));
  }
}
