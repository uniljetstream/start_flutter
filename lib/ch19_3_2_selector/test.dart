import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
Selector는 consumer와 같은 목적으로 사용.
Selector는 상태의 타입뿐만 아니라 그 타입의 특정 데이터까지 지정하여 전달받거나
지정한 데이터가 변경될 때 다시 빌드할 수 있게 한다.
 */
class MyDataModel with ChangeNotifier {
  int data1 = 0;
  int data2 = 10;

  void changeData1() {
    data1++;
    notifyListeners();
  }

  void changeData2() {
    data2++;
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
            title: Text('Seletor Test'),
            backgroundColor: Colors.blue,
          ),
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider<MyDataModel>.value(
                value: MyDataModel(),
              )
            ],
            child: HomeWidget(),
          )),
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
          Consumer<MyDataModel>(builder: (context, model, child) {
            return Container(
              color: Colors.green,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'consumer, data1: ${model.data1}, data2: ${model.data2}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            );
          }),
          Selector<MyDataModel, int>( //<이용할 상태의 객체 타입, 그 객체에서 이용할 데이터 타입>
            builder: (context, data, child) {
              return Container(
                  color: Colors.cyan,
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Text(
                    'seletor, data: ${data}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )));
            },
            selector: (context, model) => model.data2,
            //여기서 지정한 함수의 리턴값은 builder에서 지정한 함수의 두번째 매개변수로 전달됨
            //즉 data2값이 변경될 때만 Selector의 builder에 지정한 위젯을 다시 빌드함.
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  var model1 = Provider.of<MyDataModel>(context, listen: false);
                  model1.changeData1();
                },
                child: Text('model data1 change'),
              ),
              ElevatedButton(
                onPressed: () {
                  var model1 = Provider.of<MyDataModel>(context, listen: false);
                  model1.changeData2();
                },
                child: Text('model data2 change'),
              ),
            ],
          )
        ],
      )),
    );
  }
}
