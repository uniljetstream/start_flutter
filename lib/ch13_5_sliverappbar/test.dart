import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(onPressed: () {}, icon: Icon(Icons.expand)),
                expandedHeight: 200,
                floating: true, //다시 나타날 때 가장 먼저 나타나야 하는지 설정
                pinned: false,  //스크롤 되어 접힐 때 모두 사라져하는지 설
                snap: true,   //스크롤이 멈추었을때 계속 나타나야하는지 설정
                elevation: 50,
                backgroundColor: Colors.pink,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images_9_3/big.jpeg'),
                          fit: BoxFit.fill)),
                ),
                title: Text('AppBar Title'),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add_alert),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.phone),
                    onPressed: () {},
                  )
                ],
              ),
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Hellow World Item $index'),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
