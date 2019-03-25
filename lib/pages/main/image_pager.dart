import 'package:flutter/material.dart';
import 'package:flutter_study/view/banner_view.dart';

// 轮播

class ImagePager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ImagePagerState();
}

class _9itemPagerState extends State<ImagePager>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}
class _ImagePagerState extends State<ImagePager> {
  int sliderIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    List<Widget> banners = [Image.asset('images/ry.jpg'),Image.asset('images/ry.jpg'),Image.asset('images/ry.jpg')];
    // TODO: implement build
   return Container(
     alignment: Alignment.center,
     height: 200.0,
     child: new BannerView(banners),
   );
  }
}
