import 'package:flutter/material.dart';
import 'dart:ui';

// 设置图片滤镜模糊
//class ImageBlur extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MaterialApp(
//      title: 'imageBlur',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(
//        body: ImageBlurPager(),
//      ),
//    );
//  }
//}

class ImageBlurPager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints.expand(), // 限制，设置为可扩展
            child: Image.network(
                'https://timgsa.baidu.com/timg?image&quality=80&size'
                '=b9999_10000&sec=1545738629147&di=22e12a65bbc6c4123ae5596e24dbc5d3&imgtype=0&src=http%3'
                'A%2F%2Fpic30.photophoto.cn%2F20140309%2F0034034413812339_b.jpg'),
          ),
          Center(
            // 裁切长方形
            child: ClipRect(
              // 背景滤镜
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                // 透明控件
                child: Opacity(
                  opacity: 0.5,
                  child: Container( // 若不设置长宽大小则为整个背景模糊
                    width: 500.0,
                    height: 700.0,
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    child: Center(
                      child: Text(
                        '模糊',
                        style: Theme.of(context).textTheme.display3, // 设置字体样式
                      ),
                    ),
                  ),
                ),
              ), // 图片模糊过滤，横向竖向设置5.0
            ),
          )
        ],
      ),
    );
  }
}
