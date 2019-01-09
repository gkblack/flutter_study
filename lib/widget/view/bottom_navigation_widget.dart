import 'package:flutter/material.dart';
import 'package:flutter_study/page/home_pager.dart';
import 'package:flutter_study/page/notice_pager.dart';
import 'package:flutter_study/page/android_pager.dart';
import 'package:flutter_study/page/setting_dart.dart';
import 'package:flutter_study/page/list_pager.dart';

//底部导航栏
class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _BottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState() {
    // TODO: implement initState
    list
      ..add(homePager())
      ..add(NoticePager())
      ..add(AndroidPager())
      ..add(ListPager())
      ..add(SettingPager());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _BottomNavigationColor,
              ),
              title: Text(
                '首页',
                style: TextStyle(color: _BottomNavigationColor),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                color: _BottomNavigationColor,
              ),
              title: Text(
                '提示',
                style: TextStyle(color: _BottomNavigationColor),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.android,
                color: _BottomNavigationColor,
              ),
              title: Text(
                '安卓',
                style: TextStyle(color: _BottomNavigationColor),
              )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: _BottomNavigationColor,
            ),
            title: Text(
              '列表',
              style: TextStyle(color: _BottomNavigationColor),
            )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: _BottomNavigationColor,
              ),
              title: Text(
                '设置',
                style: TextStyle(color: _BottomNavigationColor),
              )
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
