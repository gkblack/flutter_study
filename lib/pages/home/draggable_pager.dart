import 'package:flutter/material.dart';

import 'package:flutter_study/widget/draggable_widget.dart';

//拖拽功能

class DraggablePager extends StatefulWidget{
  @override
  _DraggablePagerState createState() => _DraggablePagerState();

}

class _DraggablePagerState extends State<DraggablePager>{

  Color _draggableColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('拖拽'),
      ),
      body: Stack(  //层叠布局
        children: <Widget>[
          DraggableWidget(
            offset: Offset(80.0, 80.0),
            widgetColor: Colors.tealAccent,
          ),
          DraggableWidget(
            offset: Offset(180.0, 80.0),
            widgetColor: Colors.redAccent,
          ),
          Center(
            child: DragTarget(
              onAccept: (Color color){
                _draggableColor =  color;
              },
                builder: (context,candidateData, rejectedData) {
                  return Container(
                    width: 200.0,
                    height: 200.0,
                    color: _draggableColor,
                  );
                }),
          )
        ],
      ),
    );
  }

}