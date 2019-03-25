import 'package:flutter/material.dart';
import 'package:flutter_study/pages/main/home_pager.dart';
import 'package:flutter_study/pages/main/notice_pager.dart';
import 'package:flutter_study/pages/main/android_pager.dart';
import 'package:flutter_study/pages/main/setting_pager.dart';
import 'package:flutter_study/pages/main/list_pager.dart';
import 'package:flutter_study/pages/main/image_pager.dart';
import 'package:flutter_study/pages/main/tab_pager.dart';

//底部导航栏
class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _BottomNavigationColor = Colors.grey;
  final _BottomSelectColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState() {
    // TODO: implement initState
    list
      ..add(HomePager())
      ..add(NoticePager())
      ..add(AndroidPager())
      ..add(ListPager())
      ..add(SettingPager())
      ..add(ImagePager())
      ..add(TabPager());
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
              activeIcon: Icon(Icons.home, color: _BottomSelectColor,),
              title: Text(
                '首页',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                color: _BottomNavigationColor,
              ),
              activeIcon: Icon(Icons.home, color: _BottomSelectColor,),
              title: Text(
                '提示',
//                style: TextStyle(color: _BottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.store,
                color: _BottomNavigationColor,
              ),
              activeIcon: Icon(Icons.home, color: _BottomSelectColor,),
              title: Text(
                '安卓',
//                style: TextStyle(color: _BottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: _BottomNavigationColor,
              ),
              activeIcon: Icon(Icons.home, color: _BottomSelectColor,),
              title: Text(
                '列表',
//                style: TextStyle(color: _BottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.adjust,
                color: _BottomNavigationColor,
              ),
              activeIcon: Icon(Icons.home, color: _BottomSelectColor,),
              title: Text(
                '混合',
//                style: TextStyle(color: _BottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.image,
                color: _BottomNavigationColor,
              ),
              activeIcon: Icon(Icons.home, color: _BottomSelectColor,),
              title: Text(
                '图片',
//                style: TextStyle(color: _BottomNavigationColor),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tab,
              color: _BottomNavigationColor,
            ),
            activeIcon: Icon(Icons.home, color: _BottomSelectColor,),
            title: Text(
              'Tab',
//              style: TextStyle(color: _BottomNavigationColor),
            ),
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
