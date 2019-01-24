import 'package:flutter/material.dart';

//类似网易云顶部的tab页



class TabPager extends StatefulWidget {
  TabPager({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TabPagerState createState() => _TabPagerState();
}

class _TabPagerState extends State<TabPager> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
            child: new Text(''),
              flex: 1,
            ),
            Expanded(
                flex: 3,
                child: new TabBar(
                    indicatorWeight: 1.0,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(
                        child: Text('主页'),
                      ),
                      Tab(
                        child: Text('热点'),
                      ),
                      Tab(
                        child: Text('我的'),
                      ),
                    ],
                  controller: _tabController,
                ),
            ),
            Expanded(
              child: Text(''),
              flex: 1,
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          new Center(child: Text('主页'),),
          new Center(child: Text('热点'),),
          new Center(child: Text('my'),)
        ],
      ),
    );
  }
}
