import 'package:flutter/material.dart';
/*
위젯 구조
  ParentWidgetState
IconWidget  ContentWidget
 */

void main() {
  runApp(ParentWidget());
}

class ParentWidget extends StatefulWidget {
  @override
  ParentWidgetState createState() => ParentWidgetState();
}

class ParentWidgetState extends State<ParentWidget> {
  bool favorited = false;
  int favoritedCount = 10;

  void toggleFavorite() {
    setState(() {
      if (favorited) {
        favoritedCount -= 1;
        favorited = false;
      } else {
        favoritedCount += 1;
        favorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('State Test'),
              backgroundColor: Colors.blue,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconWidget(favorited: favorited, onChanged: toggleFavorite),
                ContentWidget(favoriteCount: favoritedCount),
              ],
            )));
  }
}

class IconWidget extends StatelessWidget {
  final bool favorited;
  final Function onChanged;

  IconWidget({this.favorited = false, required this.onChanged});

  void _handleTap() {
    //_handleTap() 이 호출되면 onChanged()가 호출, 이 때 onChanged() 필드에 대입된 toggleFavorite함수가 호출
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: IconButton(
      onPressed: _handleTap,
      icon: (favorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
      iconSize: 200,
      color: Colors.red,
    ));
  }
}

class ContentWidget extends StatelessWidget {
  final int favoriteCount;

  ContentWidget({required this.favoriteCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text(
            'favoriteCount : $favoriteCount',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
