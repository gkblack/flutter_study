import 'package:flutter/material.dart';

class IndicatorUtil{

  static Widget generateIndicatorItem({bool normal = true, double indicatorSize = 8.0}){

    return new Container(
      width: indicatorSize,
      height: indicatorSize,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: normal ? Colors.white : Colors.red,
      ),
    );
  }
}