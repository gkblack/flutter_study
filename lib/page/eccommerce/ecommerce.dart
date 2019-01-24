import 'package:flutter/material.dart';

class EcommercePage extends StatelessWidget{
  final List<String> categories = ['dc','Sales','Collection','Vouchers','Categories'];
  final List<String> images = ['assets/img/1.jpg','assets/img/3.jpg','assets/img/2.jpg','assets/img/4.jpg'];
  final List<String> flashSaleImages = ['assets/img/f1.jpg','assets/'];

  @override
  Widget build(BuildContext context) {

//    if(index == 0) return
    // TODO: implement build
    return null;
  }

  Widget _buildPopular(){
    return Container(
      height: 180,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[

              ],
            ),
          )
        ],
      ),
    );
  }

}