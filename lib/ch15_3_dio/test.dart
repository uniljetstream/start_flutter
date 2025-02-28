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
      var dio = Dio(BaseOptions(  //dio 객체의 생성자 매개변수로 BaseOptions 객체를 지정. 다양하게 설정 가능
          baseUrl: "https://reqres.in/api/",    //서버 공통 URL
          connectTimeout: 5000,   //dio 5.0.0 부터 뭐가 달라져서 오류 생기는 듯?
          receiveTimeout: 5000,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',  //공통URL뒤 path부분
            HttpHeaders.acceptHeader: 'application/json'
          }));
      List<Response<dynamic>> response = await Future.wait([    //동시 요청
        dio.get('https://regres.in/api/users?page=1'),
        dio.get('https://reqres.in/api/users?page=2')
      ]);
      response.forEach((element) {  //동시 요청의 결과는 List<Response> 타입으로 나옴
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
