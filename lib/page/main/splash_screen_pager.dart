import 'package:flutter/material.dart';
import 'package:flutter_study/widget/view/bottom_navigation_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


//void main() => SplashScreenPager();
// splash页
class SplashScreenPager extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'splash',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
//      localizationsDelegates: [
//        const Transla
//      ],
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SplashScreenState();

}

// SingleTickerProviderStateMixin 动画效果
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;
  var status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    /* 动画时间监听器
     */
    _animation.addStatusListener((status) {
      // 动画结束后执行下一步指令
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomNavigationWidget())
            , (route) => route == null);
      }
    });
    _controller.forward();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FadeTransition( // 透明度动画组件
        opacity: _animation,
        child: Image.asset(
          'images/289fee.jpg',
//        'https://i.pximg.net/img-original/img/2019/01/08/01/26/29/72552964_p0.png',
          scale: 2.0, // 缩放
          fit: BoxFit.cover, // 充满父容器
         ),);
  }

}
