import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

Stream<int> streamFun() async* {  //1초마다 1, 2, 3, 4, 5 생성
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;  //i 값 반환
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
            title: Text('FuterProvider, StreamProvider', style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.black,
          ),
          body: MultiProvider(
            providers: [
              FutureProvider<String>( //4초후 hello => world
                create: (context) =>
                    Future.delayed(Duration(seconds: 4), () => "world"),
                initialData: "hello",
              ),
              StreamProvider<int>(
                  create: (context) => streamFun(), initialData: 0),
            ],
            child: SubWidget(),
          )
      ),
    );
  }
}

class SubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var futureState = Provider.of<String>(context);
    var streamState = Provider.of<int>(context);
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'future : ${futureState}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'stream : ${streamState}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}