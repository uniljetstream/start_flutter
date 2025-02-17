import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  onPressGet() async {
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
    };
    http.Response response = await http.get(    //데이터를 조회할 때 사용
        Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
        headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        result = response.body;
      });
    } else {
      print('error......');
    }
  }

  onPressPost() async { //서버에 새로운 데이터를 생성하거나 추가할 때 사용되며, 요청 body에 데이터를 담습니다. 즉 url에 데이터를 담지 않음.
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

  onPressClient() async { //같은 url로 계속 요청시 접속을 끊었다 접속했다 반복하는 것 비효율적. 한 번 연결때 접속을 계속 유지하는 것이 client객체의 역할
    var client = http.Client();
    try {
      http.Response response = await client.post(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          body: {'title': 'hello', 'body': 'wordl', 'userId': '1'});

      if (response.statusCode == 200 || response.statusCode == 201) {
        response = await client
            .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
        setState(() {
          result = response.body;
        });
      } else {
        print('error....');
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    onPressed: onPressGet,
                    child: Text('GET'),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.cyan)),
                  ),
                  ElevatedButton(
                    onPressed: onPressPost,
                    child: Text('POST'),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.green)),
                  ),
                  ElevatedButton(
                    onPressed: onPressClient,
                    child: Text('Client'),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                  ),
                ],
              ),
            )));
  }
}

/*
────────────────────────────

    1. GET
    ────────────────────────────
    • 역할: 서버에서 데이터를 조회(read)하거나 리소스를 가져오기 위해 사용됩니다.
    • 사용 방식:
    - URL에 필요한 식별자나 쿼리 스트링으로 파라미터를 전달합니다.
    - 본문(body)은 사용하지 않습니다.
    • 특징:
    - 부작용이 없는(request side-effect 없는) 요청으로 간주되어, 동일 요청 시마다 같은 결과를 반환해야 합니다.
    - 브라우저 캐싱, 북마크, 히스토리 등에 저장될 수 있습니다.
    - 웹 페이지 로딩이나 RESTful API에서 데이터 조회 시 주로 사용됩니다.

────────────────────────────

2. POST

────────────────────────────

• 역할: 새로운 데이터를 생성(create)하거나 서버 자원에 추가할 때 사용합니다.

• 사용 방식:

- 요청 본문(body)에 데이터를 담아 전송합니다.

- URL은 데이터의 목적지(subject)를 가리키며, 실제 데이터는 본문에 포함됩니다.

• 특징:

- 서버 상태를 변경하는 작업(create 등)에 주로 사용됩니다.

- 캐싱되지 않는 경우가 많으며, 데이터가 많거나 보안상의 이유로 URL에 표시되지 않아야 할 때 유용합니다.

- 예를 들어, 회원가입, 게시글 작성, 파일 업로드 등에 사용됩니다.

────────────────────────────

3. PUT

────────────────────────────

• 역할: 기존 리소스를 전체적으로 대체(update)하거나 생성할 때 사용됩니다.

• 사용 방식:

- 요청 본문(body)에 자원의 전체 정보를 담아 서버에 전송합니다.

- 요청 URL에 자원의 식별자(identifier)를 포함하여, 어느 리소스를 대상으로 하는지 명시합니다.

• 특징:

- 일반적으로 클라이언트가 보유한 전체 데이터로 리소스를 덮어쓰므로, 보내지 않은 값은 모두 삭제될 수 있습니다.

- "전체 교체" 방식이 기본이나, 일부 API에서는 부분 업데이트에 PUT을 사용하기도 합니다.

- 앞서 리소스를 식별할 수 있는 URL을 사용하므로, 동일한 URL에 대해 여러 번 PUT 요청 시 항상 같은 결과를 기대할 수 있습니다.

────────────────────────────

4. DELETE

────────────────────────────

• 역할: 서버에서 특정 리소스를 삭제(delete)하기 위해 사용됩니다.

• 사용 방식:

- URL에 삭제할 리소스의 식별자를 포함시키며, 일반적으로 본문은 필요하지 않습니다.

• 특징:

- 요청이 성공하면 해당 리소스는 서버에서 제거됩니다.

- 일부 서버나 API에서는 삭제 작업 시 추가 확인이나 별도의 상태 코드(예: 204 No Content)를 반환하여 삭제 여부를 명시하기도 합니다.
- 주의할 점은, 실제 삭제 과정에서 복구가 불가능하거나 연쇄 삭제 등 부수 효과가 있을 수 있으므로 신중하게 사용해야 합니다.

────────────────────────────

요약

────────────────────────────

    GET: 리소스나 데이터를 조회할 때 사용하며, 부작용이 없어 캐싱 등의 이점을 갖습니다.
    POST: 새로운 데이터를 생성하거나 추가할 때 사용되며, 요청 본문에 데이터를 담습니다.
    PUT: 기존 리소스를 전체적으로 대체할 때 사용되며, 리소스 전체 정보를 요청 본문에 담아 전송합니다.
    DELETE: 서버 내 리소스를 삭제할 때 사용되며, URL에 식별자를 포함해 지정합니다.

이 네 메서드는 RESTful 웹 서비스의 기본 동작을 정의하며, 각 메서드를 적절히 활용함으로써 서버와 클라이언트 간의 명확한 통신 규칙을 확립할 수 있습니다.
 */
