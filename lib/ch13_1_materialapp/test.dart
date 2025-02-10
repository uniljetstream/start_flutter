import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          /*
          Material Design의 최신 가이드라인(특히 Material 3)의 변화로 primarySwatch는
          모든 위젯의 색깔을 변경시키지 않고 색조의 맡바탕이 되는 팔레트 역할을 하게 되었다.
          이 경우는 핑크색의 여러단계(옅은~진한)에서 골라 위젯 별 바탕색이 됨. 근데 티가 안남...

           */
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.black,
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Test'),
          ),
          body: Center(
            child: Column(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('Button')),
                  Checkbox(value: true, onChanged: (value) {}),
                  Text('HelloWorld'),
                ]
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {}, child: Icon(Icons.add),),
        )
    );
  }
}