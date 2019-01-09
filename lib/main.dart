import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_study/widget/ListViewPager.dart';
import 'package:flutter_study/widget/bezierPager.dart';
import 'package:flutter_study/widget/SpringySliderPager.dart';
import 'package:flutter_study/widget/view/bottom_navigation_widget.dart';

void main() => runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '随机数',
//    home: new TimerPage(title:'计数'),
      home: new HomePage(),
//    home: new RandomWordsWidget(),
    )
//  MyApp()
//    MaterialApp(
//      title: '数据传递示例',
//      home: ProductList(
//          products: List.generate(20, (i) => Product('商品 $i', '商品描述'))),
//    )
        );
//void main() => runApp(MaterialApp(
//  title: '导航',
//  home: new FirstScreen(),
//));

class Product {
  final String title; //商品标题
  final String description; //商品描述
  Product(this.title, this.description);
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({Key key, @required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表'),
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(products[index].title),
              onTap: () {},
            );
          }),
    );
  }
}

//生成随机字符串
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

class TimerPage extends StatefulWidget {
  final String title;
  TimerPage({Key key, this.title}) : super(key: key);
  @override
  _TimerPageState createState() => new _TimerPageState();
}

class _RowPage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.add),
          title: Text('Row'),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('listView'),
                Text('tete'),
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
            new RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => BottomNavigationWidget()));
              },
              child: Text("导航页"),
            )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _RowPage createState() => new _RowPage();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class _TimerPageState extends State<TimerPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display2,
            ),
            new RandomWordsWidget(),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'floatingButton',
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
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
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
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

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(title: Text('首页导航')),
      body: Center(
        child: RaisedButton(
          child: Text('查看详情'),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new SecondScreen()));
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('第二页'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
