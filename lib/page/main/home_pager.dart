import 'package:flutter/material.dart';
import 'package:flutter_study/page/listview_pager.dart';
import 'package:flutter_study/page/bezier_pager.dart';
import 'package:flutter_study/page/springy_slider_pager.dart';
import 'package:flutter_study/page/second_animation_pager.dart';
import 'package:flutter_study/page/zoom_image_pager.dart';
import 'package:flutter_study/page/home/guide_pager.dart';
import 'package:flutter_study/page/home/draggable_pager.dart';
import 'package:flutter_study/page/home/image_blur_pager.dart';

import 'package:open_file/open_file.dart';

class HomePager extends StatefulWidget {
  @override
  _homePagerState createState() => new _homePagerState();
}

class _homeBuilder {
  static Widget homeDrawer() {
    return ListView(
//      padding: const EdgeInsets.only(),
      children: <Widget>[
        _drawerHeader(),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(child: new Text("L"),
            ),
            title: new Text("Drawer1"),
            onTap: () => {},
          ),
        )
      ],
    );
  }

  static Widget _drawerHeader() {
    return new UserAccountsDrawerHeader(
        accountName: new Text(
          "Raokii", style: TextStyle(color: Colors.blueGrey),),
        accountEmail: new Text(
          "xxx@gmail.com", style: TextStyle(color: Colors.white),),
        currentAccountPicture: new CircleAvatar(
          backgroundImage: new AssetImage("images/ry.jpg"),
        ),
        onDetailsPressed: (){},
        otherAccountsPictures: <Widget>[
          new CircleAvatar(
            backgroundImage: new AssetImage("images/289ee.jpg"),
          )
        ],
    );
  }
}


class _homePagerState extends State<HomePager> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Row'),
        ),
        drawer: new Drawer(
          child: _homeBuilder.homeDrawer(),
        ),
        body: new ListView(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.android,
                      color: Colors.blue,
                    ),
                    Text('安装')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.title,
                      color: Colors.pink,
                    ),
                    Text('标题')
                  ],
                ),
                Column(
                  children: <Widget>[Icon(Icons.bluetooth), Text('蓝牙')],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.credit_card,
                      color: Colors.orangeAccent,
                    ),
                    Text('卡片')
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: new Image.asset('images/ry.jpg')),
                Expanded(
                  flex: 2,
                  child: new Image.asset('images/ry.jpg'),
                ),
                Expanded(
                  child: new Image.asset('images/ry.jpg'),
                ),
              ],
            ),
            //评分五角星
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  new Icon(
                    Icons.star,
                    color: Colors.green[500],
                  ),
                  new Icon(
                    Icons.star,
                    color: Colors.green[500],
                  ),
                  new Icon(
                    Icons.star,
                    color: Colors.green[500],
                  ),
                  new Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                  new Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                ]),
                Text(
                  '999+评论',
                  style: new TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 13.0),
                )
              ],
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ListViewPage()));
              },
              color: Colors.redAccent,
              child: new Text('ddfa'),
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new BezierPage()));
              },
              child: Text('bezier'),
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SpringySliderPager()));
              },
              child: Text("SpringSliderPager"),
            ),
            RaisedButton(
                child: Text('拖拽'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new DraggablePager()));
                }),
            RaisedButton(
              child: Text(
                '读取ppt',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                OpenFile.open(
                    "/storage/emulated/0/tencent/MicroMsg/Download/运营升职加薪年终汇报PPT模板.pptx");
              },
            ),
            Row(
              children: <Widget>[
                new RaisedButton(
                    child: Text('跳转动画'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                              new SecondAnimationPager()));
                    }),
                new RaisedButton(
                    child: Text('双指放大图片'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new ZoomImagePager()));
                    }),
                RaisedButton(
                    child: Text('导航'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GuidePager()));
                    }),

              ],
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                    child: Text('模糊'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageBlurPager()));
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
