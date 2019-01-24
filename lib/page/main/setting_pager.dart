import 'package:flutter/material.dart';

/**
 * 浮层，显示在之上的文本
 */

class SettingPager extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var stack = new Stack(
      alignment: const FractionalOffset(0.5, 0.8),
      children: <Widget>[
        new CircleAvatar(
          backgroundImage: new NetworkImage(
              'http://202.38.194.98/Wisdom/upload/message.png'),
          radius: 100.0,
        ),
        //设置在wedget中的位置
        new Positioned(
          child: new Text('dadfa'),
          bottom: 10.0,
          right: 10.0,
        ),
        new Positioned(
          child: new Text('左上'),
          left: 10.0,
          top: 10.0,
        ),
        new RaisedButton(
          onPressed: () {
//          Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondScreen())),
          },
          color: Colors.redAccent,
          child: new Text('ddfa'),
        ),
//        new Container(
//          //容器背景颜色
//          decoration: new BoxDecoration(
//            color: Colors.orangeAccent,
//          ),
//          padding: EdgeInsets.all(10.0),
//          child: Text('dshieae'),
//        )
      ],
    );
    return MaterialApp(
      title: 'ListView widget',
      home: Scaffold(
        appBar: new AppBar(
          leading: Icon(Icons.add),
          title: new Text('垂直方向布局'),
        ),
        body: Center(child: stack),
      ),
    );
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(
//        appBar: new AppBar(
//          title: new Text('title_flutter'),
//        ),
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Center(child: Text('top'),),
//          Expanded(child: Center(child: Text('www.raoki.com'),)),
//          Center(child: Text('dadae'),)
//        ],
//        //垂直布局
////        crossAxisAlignment: CrossAxisAlignment.start,
////        children: <Widget>[
////          Text('column4'),
////          Text('column1_wiget'),
////          Text('column3')
////        ],
//      ),
////        body: new Row(
////          children: <Widget>[
////            new RaisedButton(
////                onPressed: (){},
////                color: Colors.redAccent,
////                child: new Text('红色按钮'),
////            ),
////            Expanded(child: new RaisedButton(
////                onPressed: (){},
////                color: Colors.orangeAccent,
////                child: new Text('黄色按钮'),),
////            ),
////            Expanded(child: new RaisedButton(
////                onPressed: (){},
////                color: Colors.lightGreenAccent,
////                child: new Text('绿色按钮'),),
////            ),
////            Expanded(child: new RaisedButton(
////                onPressed: (){},
////                color: Colors.pinkAccent,
////                child: new Text('pink按钮'),),
////            ),
////          ],
////        ),
//      )
//    );
  }
}
