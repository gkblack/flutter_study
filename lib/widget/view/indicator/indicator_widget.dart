import 'package:flutter/material.dart';

import '../banner_view.dart';

import 'IndicatorUtil.dart';


class IndicatorWidget extends StatelessWidget{
  final IndicatorContainerBuilder indicatorBuilder;
  final Widget indicatorSelected;
  final Widget indicatorNormal;
  final double indicatorMargin;
  final int Size;
  final int currentIndex;

  IndicatorWidget({Key key, this.indicatorBuilder,this.indicatorSelected, this.indicatorNormal, this.indicatorMargin = 5.0, this.Size, this.currentIndex});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return this._renderIndicator(context);
  }

  // 指示器容器
  Widget _renderIndicator(BuildContext context){
    Widget smallContainer = new Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _renderIndicatorTag(),
      ),
    );
    if(null != this.indicatorBuilder){
      return this.indicatorBuilder(context, smallContainer);
    }

    return new Align(
     alignment: Alignment.bottomCenter,
     child: Opacity(opacity: 0.5,//透明度
        child: Container(
          height: 40.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          color: Colors.black45,
          alignment: Alignment.centerRight,
          child: smallContainer,
        ),
     ),
    );
  }

  // 生成指示器item
  List<Widget> _renderIndicatorTag(){
    List<Widget> indicators = [];
    final int len = this.Size;
    Widget selected = this.indicatorSelected ?? IndicatorUtil.generateIndicatorItem(normal: false);
    Widget normal = this.indicatorNormal ?? IndicatorUtil.generateIndicatorItem(normal: false);

    for(var index = 0; index < len; index++){
      indicators.add(index == this.currentIndex ? selected : normal);
      if(index != len - 1){
        indicators.add(new SizedBox(width: this.indicatorMargin,));
      }
    }
  }
}
