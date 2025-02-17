import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> creatState() {
    return MYAppState();
  }
}

class MyAppState extends State<MyApp> {
  String result = '';

  onPressGet() async {
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
    };
    http.Response response = await http.get(
        Uri.parse('https://jsonplcaeholder.typicode.com/posts/1'),
        headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        result = response.body;
      });
    } else {
      print('error......');
    }
  }

  onPressPost() async {
    try {
      http.Response response = await http.post(
          Uri.parse('http://jsonplaceholder.typicode.com/posts'),
          body: {'title': 'hello', 'body': 'world', 'userId': '1'});
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          result = response.body;
        });
      } else {
        print('error.....');
      }
    } catch (e) {
      print('error...$e');
    }
  }

  onPressClient() async {
    var client = http.Client();
    try {
      http.Response response = await client.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts')
      )
    }
  }
}
