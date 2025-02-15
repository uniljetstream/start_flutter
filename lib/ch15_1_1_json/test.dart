import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppStore();
  }
}

class Todo {
  int id;
  String title;
  bool completed;

  Todo(this.id, this.title, this.completed);

  Todo.fromJson(Map<String, dynamic> json)  //json 디코딩, 생성자 임.
      : id = json['id'],
        title = json['title'],
        completed = json['completed'];

  Map<String, dynamic> toJson() =>  //json 인코딩, 함수 임.
      //toJson() 에는 문자열을 json으로 바꾸는 jsonEncode함수가 내부에서 호출됨.
      {'id': id, 'title': title, 'completed': completed};
}

class MyAppStore extends State<MyApp> {
  String jsonStr = '{"id" : 1, "title" : "HELLO", "completed" : false}';
  Todo? todo;
  String result = '';

  onPressDecode() {
    Map<String, dynamic> map = jsonDecode(jsonStr);
    todo = Todo.fromJson(map);
    setState(() {
      result =
          "decode : id : ${todo?.id}, title : ${todo?.title}, completed : ${todo?.completed}";
    });
  }

  onPressEncode() {
    setState(() {
      result = "encode : ${jsonEncode(todo)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Test'),
            backgroundColor: Colors.red,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$result'),
                ElevatedButton(
                  onPressed: onPressDecode,
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  child: Text(
                    'Decode',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                    onPressed: onPressEncode,
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
                    child: Text(
                      'Encode',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          )),
    );
  }
}
