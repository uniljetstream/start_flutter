import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  XFile? _image;  //pickImage() 의 결과값 image객체는 XFile 타입의 객체이며 path 속성에 이미지 파일의 경로가 잇다.

  Future getGalleryImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery); //갤러리의 이미지 선택하
    setState(() {
      _image = image;
    });
  }

  Future getCameraImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);  //카메라로 사진 찍기

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Picker")),
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (<Widget>[
              ElevatedButton(
                  onPressed: getGalleryImage, child: Text('gallery')),
              Center(
                child: _image == null
                    ? Text(
                        'No image selected',
                        style: TextStyle(color: Colors.white),
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(File(_image!.path)),
                        radius: 100,
                      ),
              ),
              ElevatedButton(onPressed: getCameraImage, child: Text('camera'))
            ]),
          ),
        ),
      ),
    );
  }
}
