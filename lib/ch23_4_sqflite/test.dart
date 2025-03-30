import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

//shared_preferences 보다 구조화되고 대량으로 저장하는 파일 데이터베이스 패키지 : sqflite
//그 좀 이해가 필요한 파트이다.
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NativePluginWidget(),
    );
  }
}

class User {
  int? id;
  String? name;
  String? address;

  Map<String, Object?> toMap() {    //db에 저장할 때 객체의 속성값을 Map 객체로 만듬.
    var map = <String, Object?>{"name": name, "address": address};
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  User.fromData(this.name, this.address);

  User.fromMap(Map<String, Object?> map) { //데이터베이스의 Map 데이터를 객체의 속성에 대입.
    id = map["id"] as int;
    name = map['name'] as String;
    address = map['address'] as String;
  }
}

class NativePluginWidget extends StatefulWidget {
  @override
  NativePluginWidgetState createState() => NativePluginWidgetState();
}

class NativePluginWidgetState extends State<NativePluginWidget> {
  @override
  void initState() {
    super.initState();
    _createTable();
  }

  var db;

  _createTable() async {  //db 생성
    db = await openDatabase(  //version : 개발자 지정 db 버전.
        "my_db.db", version: 1, onCreate: (Database db, int version) async {
          //onCreate : 앱 설치 후 openDatabase()로 처음 데이터베이스를 이용할 때 딱 한번 호출. 주로 테이블 생성 작업을 작성
      await db.execute('''  
        CREATE TABLE User(
        id INTEGER PRIMARY KEY,
        name TEXT,
        address Text)
      ''');
      //execute()는 반환값이 없다. => 주로 테이블을 다룰 때 사용.
      //모든 SQL문을 실행 할 수 있지만 반환값이 없음. 작업별함수를 별도로 제공
      //이 밖에도 sql문을 실행 할 수 있는 함수
      //:rawQuery(), rawInsert(), rawUpdate(), rawDelete()
      //각각 SELECT, INSERT, UPDATE, DELETE문 실
    }, onUpgrade: (Database db, int oldVersion, int newVersion) {});
    //openDatabase의 version에 변경이 생기면 실행.
  }

  int lastId = 0;

  insert() async {
    lastId++;
    User user = User.fromData('name$lastId', 'seoul$lastId');
    lastId = await db.insert("User", user.toMap()); //User db에 user를 Map객체로 바꿔 삽입.
    print('${user.toMap()}');
  }

  update() async {  //마지막에 저장된 것의 lastId를 -1로 수정함.
    User user = User.fromData('name${lastId - 1}', 'seoul${lastId - 1}');
    await db.update("User", user.toMap(), where: 'id=?', whereArgs: [lastId]);
  }

  delete() async {
    await db.delete('User', where: 'id=?', whereArgs: [lastId]);
    lastId--;
  }

  query() async {
    List<Map> maps = await db.query(
      'User',
      columns: ['id', 'name', 'address'], //User db에서 id, name, address에 조회
    );
    List<User> users = List.empty(growable: true);  //User 객체를 저장할 빈 리스트 생성
    maps.forEach((element) {  //조회된 각 행에 대해 User 객체로 반복하면서 user 리스트에 추가
      users.add(User.fromMap(element as Map<String, Object?>));
    });
    if (maps.length > 0) {  //조회된 결과가 있는 경우 print문 실행
      print('select: ${maps.first}');
    }
    users.forEach((user) {  //user리스트에 있는 모든 User객체에 대해 모든 name 속성 출력
      print('${user.name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("sqflite"),),
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (<Widget>[
              ElevatedButton(onPressed: insert, child: Text('insert')),
              ElevatedButton(onPressed: update, child: Text('update')),
              ElevatedButton(onPressed: delete, child: Text('delete')),
              ElevatedButton(onPressed: query, child: Text('query')),
            ]),
          ),
        ),
      )
    );
  }
}































