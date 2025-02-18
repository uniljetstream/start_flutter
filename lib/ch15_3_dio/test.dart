//http 패키지보다 기능이 많은 dio 패키지
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  String result = '';

  dioTest() async {
    try {
      var dio = Dio(BaseOptions(
          baseUrl: "https://reqres.in/api/",
          connectTimeout: 5000,
          receiveTimeout: 5000,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json'
          }));
      List<Response<dynamic>> response = await Future.wait([
        dio.get('https://regres.in/api/users?page=1'),
        dio.get('https://reqres.in/api/users?page=2')
      ]);
      response.forEach((element) {
        if (element.statusCode == 200) {
          setState(() {
            result = element.data.toString();
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Test'),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$result'),
                ElevatedButton(
                  onPressed: dioTest,
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      foregroundColor: WidgetStatePropertyAll(Colors.black)),
                  child: Text('Get Server Data'),
                )
              ],
            ),
          )),
    );
  }
}
