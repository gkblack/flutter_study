import 'package:flutter/material.dart';

//void main() => runApp();

class ImagePager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ImagePagerState();
  }
}

class _ImagePagerState extends State<ImagePager> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: '图片',
      home: Scaffold(
        appBar: AppBar(
          title: Text('image'),
        ),
        body: Column(
          children: <Widget>[Text('image')],
        ),
      ),
    );
  }
}
