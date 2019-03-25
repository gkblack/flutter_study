import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';

import 'dart:ui';
import 'dart:math';

//弹性动画进度条
//void main() => runApp(SpringySliderPager());

class SpringySliderPager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "弹性进度条",
      theme: ThemeData(
        primaryColor: Color(0xFFFF6688),
        scaffoldBackgroundColor: Colors.white, //背景色
      ),
      home: new SySliderPage(),
    );
  }
}

class SySliderPage extends StatefulWidget {
  @override
  _SpringSliderState createState() => new _SpringSliderState();
}

class _SpringSliderState extends State<SySliderPage> {
  Widget _buildTextButton(String title, bool isOnLight) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0), //边距
      onPressed: () {},
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          color: isOnLight ? Theme.of(context).primaryColor : Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      //ClipRRect圆角矩形裁剪
      //布局内部圆角
      borderRadius: BorderRadius.circular(15.0), //设置圆角radius
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0, //阴影
          brightness: Brightness.light, //亮度
          iconTheme:
              IconThemeData(color: Theme.of(context).primaryColor), //图片主题风格
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: [
            _buildTextButton('setting'.toUpperCase(), true),
//            new Expanded(child: Container()),
//            _buildTextButton('stats'.toUpperCase(), false),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SpringySlider(
                markCount: 12,
                positiveColor: Theme.of(context).primaryColor,
                negativeColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            new Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  _buildTextButton('more', false),
                  new Expanded(child: new Container()),
                  _buildTextButton('stats'.toUpperCase(), false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpringySlider extends StatefulWidget {
  final int markCount;
  final Color positiveColor;
  final Color negativeColor;

  SpringySlider({
    this.markCount,
    this.positiveColor,
    this.negativeColor,
  });

  @override
  _SpringySliderState createState() => new _SpringySliderState();
}

class _SpringySliderState extends State<SpringySlider>
    with TickerProviderStateMixin {
  final double paddingTop = 50.0;
  final double paddingBottom = 50.0;

  SpringySliderController sliderController;

  @override
  void initState() {
    super.initState();
    sliderController = new SpringySliderController(
      sliderPercent: 0.5,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    double sliderPercent = sliderController.sliderValue;
    if (sliderController.state == SpringySliderState.springing) {
      sliderPercent = sliderController.springingPercent;
    }

    return SliderDragger(
      sliderController: sliderController,
      paddingTop: paddingTop,
      paddingBottom: paddingBottom,
      child: Stack(
        children: <Widget>[
          SliderMarks(
            markCount: widget.markCount,
            markColor: widget.positiveColor,
            backgroundColor: widget.negativeColor,
            paddingTop: paddingTop,
            paddingBottom: paddingBottom,
          ),
          SliderGoo(
            sliderController: sliderController,
            paddingTop: paddingTop,
            paddingBottom: paddingBottom,
            child: SliderMarks(
              markCount: widget.markCount,
              markColor: widget.negativeColor,
              backgroundColor: widget.positiveColor,
              paddingTop: paddingTop,
              paddingBottom: paddingBottom,
            ),
          ),
          new SliderPoints(
            sliderController: sliderController,
            paddingTop: paddingTop,
            paddingBottom: paddingBottom,
          ),
//          new SliderDebug(
//            sliderPercent: sliderController.state == SpringySliderState.dragging
//                ? sliderController.draggingPercent
//                : sliderPercent,
//            paddingTop: paddingTop,
//            paddingBottom: paddingBottom,
//          ),
        ],
      ),
    );
  }
}

//debug 显示波浪曲线水平线
class SliderDebug extends StatelessWidget {
  final double sliderPercent;
  final double paddingTop;
  final double paddingBottom;

  SliderDebug({
    this.sliderPercent,
    this.paddingTop,
    this.paddingBottom,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.maxHeight - paddingTop - paddingBottom;

        return Stack(
          children: <Widget>[
            Positioned(
              left: 0.0,
              right: 0.0,
              top: height * (1.0 - sliderPercent) + paddingTop,
              child: Container(
                height: 2.0,
                color: Colors.black,
              ),
            )
          ],
        );
      },
    );
  }
}

class SliderDragger extends StatefulWidget {
  final SpringySliderController sliderController;
  final double paddingTop;
  final double paddingBottom;
  final Widget child;

  SliderDragger({
    this.sliderController,
    this.paddingTop,
    this.paddingBottom,
    this.child,
  });

  @override
  _SliderDraggerState createState() => _SliderDraggerState();
}

class _SliderDraggerState extends State<SliderDragger> {
  double startDragY;
  double startDragPercent;

  void _onPanStart(DragStartDetails details) {
    startDragY = details.globalPosition.dy;
    startDragPercent = widget.sliderController.sliderValue;

    final sliderWidth = context.size.width;
    final sliderLeftPosition = (context.findRenderObject() as RenderBox)
        .localToGlobal(const Offset(0.0, 0.0))
        .dx;
    final dragHorizontalPercent =
        (details.globalPosition.dx - sliderLeftPosition) / sliderWidth;

    widget.sliderController.onDragStart(dragHorizontalPercent);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final dragDistance = startDragY - details.globalPosition.dy;
    final sliderHeight =
        context.size.height - widget.paddingTop - widget.paddingBottom;
    final dragPercent = dragDistance / sliderHeight;

    final sliderWidth = context.size.width;
    final sliderLeftPosition = (context.findRenderObject() as RenderBox)
        .localToGlobal(const Offset(0.0, 0.0))
        .dx;
    final dragHorizontalPercent =
        (details.globalPosition.dx - sliderLeftPosition) / sliderWidth;

    widget.sliderController.draggingPercents = new Offset(
      dragHorizontalPercent,
      startDragPercent + dragPercent,
    );
  }

  void _onPanEnd(DragEndDetails details) {
    startDragY = null;
    startDragPercent = null;

    widget.sliderController.onDragEnd();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: widget.child,
    );
  }
}

class SliderGoo extends StatelessWidget {
  final SpringySliderController sliderController;
  final double paddingTop;
  final double paddingBottom;
  final Widget child;

  SliderGoo({
    this.sliderController,
    this.paddingTop,
    this.paddingBottom,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SliderClipper(
        sliderController: sliderController,
        paddingTop: paddingTop,
        paddingBottom: paddingBottom,
      ),
      child: child,
    );
  }
}

class SliderMarks extends StatelessWidget {
  final int markCount;
  final Color markColor;
  final Color backgroundColor;
  final double paddingTop;
  final double paddingBottom;

  SliderMarks({
    this.markCount,
    this.markColor,
    this.backgroundColor,
    this.paddingTop,
    this.paddingBottom,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: new SliderMarksPainter(
        markCount: markCount,
        markColor: markColor,
        backgroundColor: backgroundColor,
        markThickness: 2.0,
        paddingTop: paddingTop,
        paddingBottom: paddingBottom,
        paddingRight: 20.0,
      ),
      child: Container(),
    );
  }
}

class SliderMarksPainter extends CustomPainter {
  final double largeMarkWidth = 30.0;
  final double smallMarkWidth = 10.0;

  final int markCount;
  final Color markColor;
  final Color backgroundColor;
  final double markThickness;
  final double paddingTop;
  final double paddingBottom;
  final double paddingRight;
  final Paint markPaint;
  final Paint backgroundPaint;

  SliderMarksPainter({
    this.markCount,
    this.markColor,
    this.backgroundColor,
    this.markThickness,
    this.paddingTop,
    this.paddingBottom,
    this.paddingRight,
  })  : markPaint = new Paint()
          ..color = markColor
          ..strokeWidth = markThickness
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
        backgroundPaint = new Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(
        0.0,
        0.0,
        size.width,
        size.height,
      ),
      backgroundPaint,
    );

    final paintHeight = size.height - paddingTop - paddingBottom;
    final gap = paintHeight / (markCount - 1);

    for (int i = 0; i < markCount; ++i) {
      double markWidth = smallMarkWidth;
      if (i == 0 || i == markCount - 1) {
        markWidth = largeMarkWidth;
      } else if (i == 1 || i == markCount - 2) {
        markWidth = lerpDouble(smallMarkWidth, largeMarkWidth, 0.5);
      }

      final markY = i * gap + paddingTop;

      canvas.drawLine(
        new Offset(size.width - paddingRight - markWidth, markY),
        new Offset(size.width - paddingRight, markY),
        markPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SliderClipper extends CustomClipper<Path> {
  final SpringySliderController sliderController;
  final double paddingTop;
  final double paddingBottom;

  SliderClipper({
    this.sliderController,
    this.paddingTop,
    this.paddingBottom,
  });

  @override
  Path getClip(Size size) {
    switch (sliderController.state) {
      case SpringySliderState.idle:
        return _clipIdle(size);
      case SpringySliderState.dragging:
        return _clipDragging(size);
      case SpringySliderState.springing:
        return _clipSpringing(size);
    }
  }

  Path _clipIdle(Size size) {
    Path rect = new Path();

    final top = paddingTop;
    final bottom = size.height;
    final height = (bottom - paddingBottom) - top;
    final percentFromBottom = 1.0 - sliderController.sliderValue;

    rect.addRect(
      new Rect.fromLTRB(
        0.0,
        top + (percentFromBottom * height),
        size.width,
        bottom,
      ),
    );

    return rect;
  }

  Path _clipDragging(Size size) {
    Path compositePath = new Path();

    final top = paddingTop;
    final bottom = size.height - paddingBottom;
    final height = bottom - top;
    final basePercentFromBottom = 1.0 - sliderController.sliderValue;
    final dragPercentFromBottom = 1.0 - sliderController.draggingPercent;

    final baseY = top + (basePercentFromBottom * height);
    final leftX = -0.15 * size.width;
    final leftPoint = Point(leftX, baseY);
    final rightX = 1.15 * size.width;
    final rightPoint = Point(rightX, baseY);

    final dragX = sliderController.draggingHorizontalPercent * size.width;
    final dragY = top + (dragPercentFromBottom * height);
    final crestPoint = Point(dragX, dragY.clamp(top, bottom));

    double excessDrag = 0.0;
    if (sliderController.draggingPercent < 0.0) {
      excessDrag = sliderController.draggingPercent;
    } else if (sliderController.draggingPercent > 1.0) {
      excessDrag = sliderController.draggingPercent - 1.0;
    }
    final baseControlPointWidth = 150.0;
    final thickeningFactor = excessDrag * height * 0.05;
    final controlPointWidth =
        (200.0 * thickeningFactor).abs() + baseControlPointWidth;

    final rect = new Path();
    rect.moveTo(leftPoint.x, leftPoint.y);
    rect.lineTo(rightPoint.x, rightPoint.y);
    rect.lineTo(rightPoint.x, size.height);
    rect.lineTo(leftPoint.x, size.height);
    rect.lineTo(leftPoint.x, leftPoint.y);
    rect.close();

    compositePath.addPath(rect, const Offset(0.0, 0.0));

    final curve = new Path();
    curve.moveTo(crestPoint.x, crestPoint.y);
    curve.quadraticBezierTo(
      crestPoint.x - controlPointWidth,
      crestPoint.y,
      leftPoint.x,
      leftPoint.y,
    );

    curve.moveTo(crestPoint.x, crestPoint.y);
    curve.quadraticBezierTo(
      crestPoint.x + controlPointWidth,
      crestPoint.y,
      rightPoint.x,
      rightPoint.y,
    );

    curve.lineTo(leftPoint.x, leftPoint.y);
    curve.close();

    if (dragPercentFromBottom > basePercentFromBottom) {
      compositePath.fillType = PathFillType.evenOdd;
    }

    compositePath.addPath(curve, const Offset(0.0, 0.0));

    return compositePath;
  }

  Path _clipSpringing(Size size) {
    Path compositePath = new Path();

    final top = paddingTop;
    final bottom = size.height - paddingBottom;
    final height = bottom - top;
    final basePercentFromBottom = 1.0 - sliderController.springingPercent;
    final crestSpringPercentFromBottom =
        1.0 - sliderController.crestSpringingPercent;

    final baseY = top + (basePercentFromBottom * height);
    final leftX = -0.85 * size.width;
    final leftPoint = Point(leftX, baseY);

    final centerX = 0.15 * size.width;
    final centerPoint = Point(centerX, baseY);

    final rightX = 1.15 * size.width;
    final rightPoint = Point(rightX, baseY);

    final crestY = top + (crestSpringPercentFromBottom * height);
    final crestPoint = Point((rightX - centerX) / 2 + centerX, crestY);

    final troughY = baseY + (baseY - crestY);
    final troughPoint = Point((centerX - leftX) / 2 + leftX, troughY);

    final controlPointWidth = 100.0;

    final rect = new Path();
    rect.moveTo(leftPoint.x, leftPoint.y);
    rect.lineTo(rightPoint.x, rightPoint.y);
    rect.lineTo(rightPoint.x, size.height);
    rect.lineTo(leftPoint.x, size.height);
    rect.lineTo(leftPoint.x, leftPoint.y);
    rect.close();

    compositePath.addPath(rect, const Offset(0.0, 0.0));

    final leftCurve = new Path();
    leftCurve.moveTo(troughPoint.x, troughPoint.y);
    leftCurve.quadraticBezierTo(
      troughPoint.x - controlPointWidth,
      troughPoint.y,
      leftPoint.x,
      leftPoint.y,
    );

    leftCurve.moveTo(troughPoint.x, troughPoint.y);
    leftCurve.quadraticBezierTo(
      troughPoint.x + controlPointWidth,
      troughPoint.y,
      centerPoint.x,
      centerPoint.y,
    );

    leftCurve.lineTo(leftPoint.x, leftPoint.y);
    leftCurve.close();

    if (crestSpringPercentFromBottom < basePercentFromBottom) {
      compositePath.fillType = PathFillType.evenOdd;
    }

    compositePath.addPath(leftCurve, const Offset(0.0, 0.0));

    final rightCurve = new Path();
    rightCurve.moveTo(crestPoint.x, crestPoint.y);
    rightCurve.quadraticBezierTo(
      crestPoint.x - controlPointWidth,
      crestPoint.y,
      centerPoint.x,
      centerPoint.y,
    );

    rightCurve.moveTo(crestPoint.x, crestPoint.y);
    rightCurve.quadraticBezierTo(
      crestPoint.x + controlPointWidth,
      crestPoint.y,
      rightPoint.x,
      rightPoint.y,
    );

    rightCurve.lineTo(centerPoint.x, centerPoint.y);
    rightCurve.close();

    if (crestSpringPercentFromBottom > basePercentFromBottom) {
      compositePath.fillType = PathFillType.evenOdd;
    }

    compositePath.addPath(rightCurve, const Offset(0.0, 0.0));

    return compositePath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SliderPoints extends StatelessWidget {
  final SpringySliderController sliderController;
  final double paddingTop;
  final double paddingBottom;

  SliderPoints({
    this.sliderController,
    this.paddingTop,
    this.paddingBottom,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double sliderPercent = sliderController.sliderValue;
        if (sliderController.state == SpringySliderState.dragging) {
          sliderPercent = sliderController.draggingPercent.clamp(0.0, 1.0);
        }

        final height = constraints.maxHeight - paddingTop - paddingBottom;
        final sliderY = height * (1.0 - sliderPercent) + paddingTop;
        final pointsYouNeedPercent = 1.0 - sliderPercent;
        final pointsYouNeed = (100 * pointsYouNeedPercent).round();
        final pointsYouHavePercent = sliderPercent;
        final pointsYouHave = 100 - pointsYouNeed;

        return Stack(
          children: <Widget>[
            Positioned(
              left: 30.0,
              top: sliderY - 10.0 - (40.0 * pointsYouNeedPercent),
              child: FractionalTranslation(
                translation: Offset(0.0, -1.0),
                child: new Points(
                  points: pointsYouNeed,
                  isAboveSlider: true,
                  isPointsYouNeed: true,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Positioned(
              left: 30.0,
              top: sliderY + 10.0 + (40.0 * pointsYouHavePercent),
              child: new Points(
                points: pointsYouHave,
                isAboveSlider: false,
                isPointsYouNeed: false,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

class Points extends StatelessWidget {
  final int points;
  final bool isAboveSlider;
  final bool isPointsYouNeed;
  final Color color;

  Points({
    this.points,
    this.isAboveSlider = true,
    this.isPointsYouNeed = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percent = points / 100.0;
    final pointTextSize = 50.0 + (50.0 * percent);

    return Row(
      crossAxisAlignment:
          isAboveSlider ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        FractionalTranslation(
          translation: Offset(-0.05 * percent, isAboveSlider ? 0.18 : -0.18),
          child: Text(
            '$points',
            style: TextStyle(
              fontSize: pointTextSize,
              color: color,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  'POINTS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Text(
                isPointsYouNeed ? 'YOU NEED' : 'YOU HAVE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SpringySliderController extends ChangeNotifier {
  // ChangeNotifier 状态改变监听

  // 弹性参数设置
  final SpringDescription sliderSpring = new SpringDescription(
    mass: 1.0,
    stiffness: 1000.0,
    damping: 30.0,
  );

  final SpringDescription crestSpring = new SpringDescription(
    mass: 1.0,
    stiffness: 5.0,
    damping: 0.5,
  );

  final TickerProvider _vsync;
  SpringySliderState _state = SpringySliderState.idle;

  //滑动值
  double _sliderPercent;

  // 用户在拖动期间的滑动值
  double _draggingPerent;

  // 用户在拖动期间的水平滑动值
  double _draggingHorizontalPercent;

  // 当弹簧有新的滑动值，改变UI
  double _springStartPerent;

  // 当弹簧有新的滑动值， this is where the UI is springing to
  double _springEndPercent;

  // springing effect 期间的当前的滑动值
  double _springingPercent;

  //Physics spring
  SpringSimulation _sliderSpringSimulation;

  double _crestSpringingPercent;
  double _crestSpringingStartPerent;
  double _crestSpringingEndPercent;
  SpringSimulation _crestSpringSimulation;

  // 计算当前弹簧位置(Ticker that computes current spring position based on time)
  Ticker _springTicker;

  //Elapsed time thate has passed since the start of the spring
  double _springTime;

  SpringySliderController({
    double sliderPercent = 0.0,
    vsync,
  })  : _vsync = vsync,
        _sliderPercent = sliderPercent;

  void dispose() {
    if (_springTicker != null) {
      _springTicker.dispose();
    }
    super.dispose();
  }

  SpringySliderState get state => _state;

  double get sliderValue => _sliderPercent;

  set sliderValue(double newValue) {
    _sliderPercent = newValue;
    notifyListeners();
  }

  double get draggingPercent => _draggingPerent;

  double get draggingHorizontalPercent => _draggingHorizontalPercent;

  set draggingPercents(Offset draggingPercents) {
    _draggingHorizontalPercent = draggingPercents.dx;
    _draggingPerent = draggingPercents.dy;
    notifyListeners();
  }

  void onDragStart(double draggingHorizontalPercent) {
    if (_springTicker != null) {
      _springTicker
        ..stop()
        ..dispose();
    }

    _state = SpringySliderState.dragging;
    _draggingPerent = _sliderPercent;
    _draggingHorizontalPercent = draggingHorizontalPercent;

    notifyListeners();
  }

  void onDragEnd() {
    _state = SpringySliderState.springing;

    _springingPercent = _sliderPercent;
    _springStartPerent = _sliderPercent;
    _springEndPercent = _draggingPerent.clamp(0.0, 1.0);

    _crestSpringingPercent = draggingPercent;
    _crestSpringingStartPerent = draggingPercent;
    _crestSpringingEndPercent = _springStartPerent;

    _draggingPerent = null;

    _sliderPercent = _springEndPercent;

    _startSpringing();

    notifyListeners();
  }

  void _startSpringing() {
    if (_springStartPerent == _springEndPercent) {
      _state = SpringySliderState.idle;
      notifyListeners();
      return;
    }

    _sliderSpringSimulation = new SpringSimulation(
      sliderSpring,
      _springStartPerent,
      _springEndPercent,
      0.0,
    );

    final crestSpringNormal =
        (_crestSpringingEndPercent - _crestSpringingStartPerent) /
            (_crestSpringingEndPercent - _crestSpringingStartPerent).abs();
    _crestSpringSimulation = new SpringSimulation(
      crestSpring,
      _crestSpringingStartPerent,
      _crestSpringingEndPercent,
      0.5 * crestSpringNormal,
    );

    _springTime = 0.0;

    _springTicker = _vsync.createTicker(_springTick)..start();

    notifyListeners();
  }

  void _springTick(Duration deltaTime) {
    final lastFrameTime = deltaTime.inMilliseconds.toDouble() / 1000.0;

    _springTime += lastFrameTime;
    _springingPercent = _sliderSpringSimulation.x(_springTime);

    _crestSpringingPercent = _crestSpringSimulation.x(lastFrameTime);
    _crestSpringSimulation = new SpringSimulation(
      crestSpring,
      _crestSpringingPercent,
      _springingPercent,
      _crestSpringSimulation.dx(lastFrameTime),
    );

    if (_sliderSpringSimulation.isDone(_springTime) &&
        _crestSpringSimulation.isDone(lastFrameTime)) {
      _springTicker
        ..stop()
        ..dispose();
      _springTicker = null;

      _state = SpringySliderState.idle;
    }
    notifyListeners();
  }

  double get springingPercent => _springingPercent;
  double get crestSpringingPercent => _crestSpringingPercent;
}

enum SpringySliderState { idle, dragging, springing }
