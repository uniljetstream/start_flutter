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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('MultiProvider Test'),
              backgroundColor: Colors.blue,
            ),
            body: MultiProvider(  //계층구조로 만들 수도 있지만 MultiProvider를 이용하면 더 쉬움.
              providers: [
                //providers의 데이터를 제네릭을 가져온다. 따라서 중복한 제네릭 타입이 있을 경우 마지막의 것을 가져오므로 주의
                Provider<int>.value(value: 10),
                Provider<String>.value(value: "hello"),
                ChangeNotifierProvider<Counter>.value(  //변화를 감지해서 SubWidget을 다시만듬.
                  value: Counter(),
                ),
              ],
              child: SubWidget(),
            )));
  }
}

class SubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<Counter>(context);
    var int_data = Provider.of<int>(context);
    var string_data = Provider.of<String>(context);
    return Container(
      color: Colors.orange,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Provider: ',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'int data : $int_data',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'string data : $string_data',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'Counter data : ${counter.count}',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          ElevatedButton(
              onPressed: () {
                counter.increment();  //increment 호출 시 notifyListeners();를 통해 리빌딩됨.
              },
              child: Text('increment'))
        ],
      )),
    );
  }
}
