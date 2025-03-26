import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Provider Test'),
              backgroundColor: Colors.blue,
            ),
            body: Provider<int>(  //생성자를 이용하여 상태데이터를 등록하는 방법, value()를 이용하는 방법도 있다.
              create: (context) { //create속성에 함수를 지정하여 함수에서 반환하는 값을 상태로 이용할 수있다.
                int sum = 0;
                for (int i = 1; i <= 10; i++) {
                  sum += i;
                }
                return sum;
              },
              child: SubWidget(),
            )
        )
    );
  }
}

class SubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<int>(context);
    //Provider.of() : 상태데이터를 얻을 수 있다.
    //Provider.of<int>() : 여기서 제네릭 타입은 상위에서 프로바이더로 제공하는 상태데이터의 타입.
    return Container(
        color: Colors.orange,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('I am SubWidget', style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),),
                Text('Provider Data : ${data}', style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),)
              ],
            )
        )
    );
  }
}

