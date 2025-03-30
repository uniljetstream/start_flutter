import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NativePluginWidget(),
    );
  }
}

class NativePluginWidget extends StatefulWidget {
  @override
  NativePluginWidgetState createState() => NativePluginWidgetState();
}

class NativePluginWidgetState extends State<NativePluginWidget> {
  String? latitude;
  String? longitude;

  getGeoData() async {
    LocationPermission permission = await Geolocator.checkPermission(); //위치 권한 얻기
    if (permission == LocationPermission.denied) {  //위치 권한이 거부라면 권한 얻기 팝업 띄우기
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {  //위치 권한을 거부한다면 에러 띄우기
        return Future.error('permissions are denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition();  //위도 경도 얻기
    setState(() {
      latitude = position.latitude.toString();  //위도와 경도는 double 타입으로 얻어짐. 문자열로 변환함
      longitude = position.longitude.toString();
    });
  }

  @override
  void initState() {
    super.initState();  //State() 클래스의 initState()를 호출함.
    getGeoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Geolocator"),
        ),
        body: Container(
          color: Colors.indigo,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (<Widget>[
                Text(
                  'MyLocation',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  'latitude: ${latitude}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'logitude: ${longitude}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
        ));
  }
}
