import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class User {
  String name;
  String phone;
  String email;

  User(this.name, this.phone, this.email);
}

class MyApp extends StatelessWidget {
  List<User> users = [
    User('홍길동', '0100001', 'a@a.com'),
    User('김길동', '0100002', 'b@a.com'),
    User('이길동', '0100003', 'c@a.com'),
    User('박길동', '0100004', 'd@a.com'),
    User('홍길동', '0100001', 'a@a.com'),
    User('김길동', '0100002', 'b@a.com'),
    User('이길동', '0100003', 'c@a.com'),
    User('박길동', '0100004', 'd@a.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Test'),
        backgroundColor: Colors.red,
      ),
      body: ListView.separated(
          itemCount: users.length,
          itemBuilder: (context, index) {
            /*
            ListView는 내부적으로 itemCount만큼 itemBuilder를 호출함
              itemBuilder(context, 0)
              itemBuilder(context, 1)
              itemBuilder(context, 2)
              itemBuilder(context, 3)
            따라서 itemBuilder함수의 인수로 들어가게 되는 거임.
             */
            return ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('images_9_3/big.jpeg'),
              ),
              title: Text(users[index].name),
              subtitle: Text(users[index].phone),
              trailing: Icon(Icons.more_vert),
              onTap: () {
                print(users[index].name);
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 2,
              color: Colors.black,
            );
          }),
    ));
  }
}
