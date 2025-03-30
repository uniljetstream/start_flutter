//내부 저장소 이용하기
//shared_preference : 앱의 데이터를 내부 저장소에 키-값 구조로 저장
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
  late SharedPreferences prefs;

  double sliderValue = 0.0;
  bool switchValue = false;

  //SharedPreferences로 저장할 수 있는 타입은 int, double, bool, String, List, <String>
  //따라서 각 타입을 저장하는 setInt(), setBool(), setDouble(), setString(), setStringLsit() 함수 제공
  //이 함수들의 첫번째 매개변수는 키, 두 번째 매개변수는 값이다.
  _save() async {
    await prefs.setDouble('slider', sliderValue);
    await prefs.setBool('switch', switchValue);
  }

  //저장한 데이터를 가져오는 함수도
  //getInt(), getBool(), getDouble(), getString(), getStringList()
  //매개변수는 가져올 데이터의 키 값이다.
  //만약 지정한 키로 저장된 데이터가 없으면 null을 반환한다.
  getInitData() async {
    prefs = await SharedPreferences.getInstance();  //데이터를 저장하거나 가져올려면 SharedPreferences 객체를 얻어야함.
    sliderValue = prefs.getDouble('slider') ?? 0.0;
    switchValue = prefs.getBool('switch') ?? false;
  }

  void initState() {
    super.initState();
    getInitData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shared Preference")),
      body: Container(
        color: Colors.yellow,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (<Widget>[
              Slider(
                  value: sliderValue,
                  min: 0,
                  max: 10,
                  onChanged: (double value) {
                    setState(() {
                      sliderValue = value;
                    });
                  }),
              Switch(
                  value: switchValue,
                  onChanged: (bool value) {
                    setState(() {
                      switchValue = value;
                    });
                  }),
              ElevatedButton(onPressed: _save, child: Text('Save'))
            ]),
          ),
        ),
      ),
    );
  }
}
