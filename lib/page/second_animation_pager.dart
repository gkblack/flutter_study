import 'package:flutter/material.dart';

void main() => runApp(new SecondAnimationPager());

class SecondAnimationPager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('跳转动画'),
        leading: Icon(Icons.keyboard_backspace),
      ),
    );
  }
}
