import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget{
  final Offset offset;
  final Color widgetColor;
  const DraggableWidget({Key key, this.offset, this.widgetColor}):super(key: key);
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget>{
  Offset offset = Offset(0.0, 0.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offset = widget.offset;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Positioned(
        left: offset.dx,
        // ignore: undefined_getter
        top: offset.dy,
        child: Draggable( //拖拽布局
            data: widget.widgetColor,
            child: Container(
              width: 100,
              height: 100,
              color: widget.widgetColor,
            ),
            feedback: Container(
              width: 100.0,
              height: 100.0,
              color: widget.widgetColor.withOpacity(0.5),
            ),
          onDraggableCanceled: (Velocity velocity, Offset offset){
              setState(() {
                // ignore: expected_token
                this.offset = offset;
              });
          },
        )
    );
  }

}