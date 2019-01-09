import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'listView',
      home: new ListViewPage(),
    ));

class ListViewPage extends StatefulWidget {
  @override
  _ListViewState createState() => new _ListViewState();
}

class _ListViewState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView'),
          leading: Icon(Icons.list),
        ),
        body: new ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.lightGreenAccent,
                  margin: EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.android,
                    size: 80.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text('標題'), Text('我的消息描述内容')],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('2018-01-4'),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: new Icon(
                    Icons.android,
                    size: 80.0,
                  ),
                  flex: 1,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text('標題'), Text('我的消息描述内容部分')],
                  ),
                  flex: 2,
                ),
                Flexible(
                  child: Text('2018-01-4'),
                  flex: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
