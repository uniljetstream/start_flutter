import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test.g.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

@JsonSerializable()
class Location {
  String latitude;
  String longitude;

  Location(this.latitude, this.longitude);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json); //자동생성되는 함수
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable(explicitToJson: true) //중첩 클래스의 값을 출력하기 위해
class Todo {
  @JsonKey(name: "id") //todoId와 대응 되는 id 항목을 나타내기 위한 부분
  int todoId;
  String title;
  bool completed;
  Location location;

  Todo(this.todoId, this.title, this.completed, this.location);

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}

class MyAppState extends State<MyApp> {
  String jsonStr =
      '{"id": 1, "title": "HELLO", "completed": false, "location": {"latitude": "37.5", "longitude": "127.1"}}';

  Todo? todo;
  String result = '';

  onPressDecode() {   //json을 문자열
    Map<String, dynamic> map = jsonDecode(jsonStr);   //json을 map 객체로 변경해줌.
    todo = Todo.fromJson(map);
    print(todo?.toJson());
    setState(() {
      result = "decode : ${todo?.toJson()}";
    });
  }

  onPressEncode() { //문자열을 json
    setState(() {
      result = "encode : ${jsonEncode(todo)}";    //map객체를 json 으로
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
                    child: Text('Decode'),
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onPressEncode,
                    child: Text('Encode'),
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue),
                    ),
                  ),
                ],
              ),
            )));
  }
}
