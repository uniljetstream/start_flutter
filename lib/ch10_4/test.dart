import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Test'),
              backgroundColor: Colors.cyan,
            ),
            body: SingleChildScrollView(  //스크롤
                scrollDirection: Axis.vertical,   //수직 스크롤
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 300,
                      child: Row(
                        children: <Widget>[
                          Container(color: Colors.red, width: 100),
                          Expanded(   //red를 제외한 영역을 1대1로 amber, yellow가 차지
                              flex: 1,
                              child: Container(
                                color: Colors.amber,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.yellow,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.green,
                      height: 300,
                      child: Row(
                        children: <Widget>[
                          Image.asset('images_10_4/lab_instagram_icon_1.jpg'),
                          Image.asset('images_10_4/lab_instagram_icon_2.jpg'),
                          Image.asset('images_10_4/lab_instagram_icon_3.jpg'),
                          Spacer(), //공백
                          Image.asset('images_10_4/lab_instagram_icon_4.jpg')
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      height: 300,
                    )
                  ],
                ))));
  }
}
