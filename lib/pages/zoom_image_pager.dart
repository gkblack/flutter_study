import 'package:flutter/material.dart';

//双指放大图片效果

class ZoomImagePager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _GridAnimationState();
  }
}

List<String> lists = [
  "http://www.wepe.com.cn/images/download/u32.png",
  "http://www.wepe.com.cn/images/download/u32.png",
//    "https://www.pixiv.net/member_illust.php?mode=medium&illust_id=72540031",
//    "https://www.pixiv.net/member_illust.php?mode=medium&illust_id=72552964",
//    "https://www.pixiv.net/member_illust.php?mode=medium&illust_id=72551247",
//    "https://www.pixiv.net/member_illust.php?mode=medium&illust_id=72552870",
//    "https://www.pixiv.net/member_illust.php?mode=medium&illust_id=72552176",
//    "https://www.pixiv.net/member_illust.php?mode=medium&illust_id=72565857",
//    "https://www.pixiv.net/member_illust.php?mode=medium&illust_id=72566118",
//    "https://www.pixiv.net/member_illust.php?mode=medium&illust_id=72566118",
//    "https://www.pixiv.net/member_illust.php?mode=medium&illust_id=72576796",
//    "https://www.pixiv.net/member_illust.php?mode=medium&illust_id=72552947",
];

class _GridAnimationState extends State<ZoomImagePager> {
  void showPhoto(BuildContext context, f, index) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('图片${index + 1}'),
        ),
        body: SizedBox.expand(
          child: Hero(
            //在路由（页面）间跳转切换的动画
            tag: index,
            child: new Photo(url: f),
          ),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('GridAnimation'),
      ),
      body: Column(
        children: <Widget>[
          new Expanded(
              child: new SafeArea(
                  top: false,
                  bottom: false,
                  child: new GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 4.0,
                    padding: const EdgeInsets.all(4.0),
                    childAspectRatio: 1.5,
                    children: lists.map((f) {
                      return new GestureDetector(
                        onTap: () {
                          var index;
                          if (lists.contains(f)) {
                            index = lists.indexOf(f);
                          }
                          showPhoto(context, f, index);
                        },
                        child: Image.network(
                          f,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ))),
        ],
      ),
    );
  }
}

class Photo extends StatefulWidget {
  final url;
  const Photo({Key key, this.url}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PhotoState();
  }
}

class PhotoState extends State<Photo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;
  double _kMinFlingVelocity = 600.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      _offset = _animation.value;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    //widget的屏幕宽度
    final Offset minOffset = Offset(size.width, size.height) * (1.0 - _scale);
    // 限制他的最小尺寸
    return Offset(
      offset.dx.clamp(minOffset.dx, 0.0),
      offset.dy.clamp(minOffset.dy, 0.0),
    );
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      //计算图片放大后的位置
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 3.0);
      //限制放大倍数 1~3倍
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
      //更新当前位置
    });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity) return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    //计算当前方向
    final double distance = (Offset.zero & context.size).shortestSide;
    //计算放大倍数，相应的放大宽高
    _animation = _controller.drive(Tween<Offset>(
        begin: _offset, end: _clampOffset(_offset + direction * distance)));
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      child: ClipRect(
        child: Transform(
          transform: Matrix4.identity()
            ..translate(_offset.dx, _offset.dy)
            ..scale(_scale),
          child: Image.network(
            widget.url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
