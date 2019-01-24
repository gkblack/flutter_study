import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_study/widget/view/bottom_navigation_widget.dart';
import 'package:flutter_study/page/main/splash_screen_pager.dart';

void main() => runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
//      home: new BottomNavigationWidget(),
      home: SplashScreenPager(),
    ));

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
