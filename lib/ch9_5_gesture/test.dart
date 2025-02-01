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
            backgroundColor: Colors.blue,
          ),
          body: Column(
            children: [
              GestureDetector(
                  child: Image.asset('images_9_5/icon/user.png'),
                  onTap: () {
                    print('image click...');
                  },
                  onVerticalDragStart: (DragStartDetails details) {
                    print('vertical drag start...global position : ${details.globalPosition.dx}, ${details.globalPosition.dy}');
                    print('vertical drag start...local position : ${details.localPosition.dx}, ${details.localPosition.dy}');
                    }
              ),
              ElevatedButton(
                onPressed: () {
                  print('ElevatedButton click...');
                },
                child: Text('Click Me'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
                        //MaterialStateProperty가 WidgetStateProperty로 대체된 듯
                ),)
            ],
          ),
        )
    );
  }
}
