//ProxyProvider는 상태를 조합할 때 이용.
//여러 프로바이더로 상태를 여러 개 선언할 때 각각의 상태를 독립적으로 이용할 수도 있지만
//어떤 상탯값을 참조해서 다른 상탯값을 결정되게 할 수도 있습니다.
//또한 한 상탯값이 변경되면 다른 상탯값도 함께 변경해야 할 때도 있다.
//이 때 참조 상태를 다른 상태에 전달해야 하는데 이를 쉽게 구현하도록 ProxyProvider 제공

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class Sum {
  int _sum = 0;

  int get sum => _sum;

  void set sum(value) {
    _sum = 0;
    for (int i = 1; i <= value; i++) {
      _sum += i;
    }
  }

  Sum(Counter counter) {
    sum = counter.count;
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
            title: Text(
              'ProxyProvider Test',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider<Counter>.value(value: Counter()),
              ProxyProvider<Counter, Sum>(
                //제네릭 선언: <Counter를 상태로 등록, Counter를 전달받아 sum 상태를 등록>
                update: (context, model, sum) {
                  //ProxyProvider는 update속성에 함수를 등록해야 하는데
                  //update에 등록한 함수가 sum 객체를 반환하므로 sum 객체가 상태로 등록됨.
                  //그런데 update 함수를 호출할 때 두번째 매개변수에 Counter가 객체가 전달됨.
                  //결국 두번재 매개변수로 전달된 상태를 참조하여 자신의 상태를 만들게 된다.
                  if (sum != null) {  //이전상태의 객체를 sum(세번째 매개변수가)이 받아 상태값만 갱신
                    sum.sum = model.count;
                    return sum;
                  } else {  //새로운 객체 생성
                    return Sum(model);
                  }
                },
              ),
              ProxyProvider2<Counter, Sum, String>(   //여러개의 ProxyProvider를 등록가능(2~6)
                //Counter, Sum은 전달받는 상태의 제네릭타입, String은 앞의 2개를 참조하서 만들 상태의 제네릭
                update: (context, model1, model2, data) { //model1은 Counter를 model2는 Sum을 받는다.
                  return "count : ${model1.count}, sum : ${model2.sum}";
                },
              )
            ],
            child: SubWidget(),
          )),
    );
  }
}

class SubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<Counter>(context);
    var sum = Provider.of<Sum>(context);
    var string_data = Provider.of<String>(context);
    return Container(
      color: Colors.orange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'count: ${counter.count}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'sum : ${sum.sum}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'string : ${string_data}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {
                counter.increment();
              },
              child: Text('increment'),
            ),
          ],
        ),
      ),
    );
  }
}
