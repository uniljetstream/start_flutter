import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDataModel1 with ChangeNotifier {
  int data = 0;

  void changeData() {
    data++;
    notifyListeners();
  }
}

class MyDataModel2 with ChangeNotifier {
  String data = "hello";

  void changeData() {
    if (data == "hello")
      data = "world";
    else
      data = "hello";
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
          title: Text(
            'Consumer Test',
          ),
          backgroundColor: Colors.blue,
        ),
        body: MultiProvider(providers: [
          ChangeNotifierProvider<MyDataModel1>.value(
            value: MyDataModel1(),
          ),
          ChangeNotifierProvider<MyDataModel2>.value(
            value: MyDataModel2(),
          )
        ],
          child: HomeWidget(),),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer2<MyDataModel1, MyDataModel2>(  //Consumer2만 상탯값이 변경될 때마다 변경됨
              //사용할 상태타입의 갯수로 Consumer2~6을 결정
              builder: (context, model1, model2, child) {
                return SubWidget1(model1, model2, child);
              },
              child: SubWidget2(),  //consumer의 child는 상탯값이 변경될 때 다시 빌드 되지 않음.
            ),
            Column(
              children: [
                ElevatedButton(onPressed: () {
                  var model1 = Provider.of<MyDataModel1>(
                      context, listen: false);
                  model1.changeData();
                }, child: Text('model1 change')),
                ElevatedButton(onPressed: () {
                  var model2 = Provider.of<MyDataModel2>(
                      context, listen: false);
                  model2.changeData();
                }, child: Text('model2 change')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SubWidget1 extends StatelessWidget {
  MyDataModel1 model1;
  MyDataModel2 model2;
  Widget? child;

  SubWidget1(this.model1, this.model2, this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text('I am SubWidget1, ${model1.data}, ${model2.data}',
            style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),),
          child!  //SubWidget1의 UI에서 SubWidet2를 포함함을 알려줌, consumer2의 child 속성임
        ],
      ),
    );
  }
}

class SubWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      padding: EdgeInsets.all(20),
      child: Text(
        'I am SubWidget2',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}




































