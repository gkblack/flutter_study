import 'package:flutter/material.dart';
import 'package:flutter_study/pages/product_list_pager.dart';


class AndroidPager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
//      new ProductList(products: null);
      title: 'title',
      home: new Scaffold(
        appBar: AppBar(title: Text('android'),),
        body: new Row(
          children: <Widget>[
            new RaisedButton(
                child: new Text('商品'), onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder
                  : (context) => new ProductPager())
              );
            }
            ),
            RouteButton(),
          ],
        ),
      ),
    );
  }
}

class RouteButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      child: Text("跳转传值"),
      onPressed: (){
        _navigateToIntent(context);
      }
    );
  }

}

// SnackBar 等同于 toast
// 弃用异步方法
_navigateToIntent(BuildContext context) async{
  final result = await Navigator.push(  //等待
      context,
      MaterialPageRoute(builder: (context) => toIntent()));

  // Toast
  Scaffold.of(context).showSnackBar(SnackBar(content: Text('$result')));
}

class toIntent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("传值回调"),),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
                child: Text("回调1"),
                onPressed: (){
                  Navigator.pop(context,'回调1111111111111');
            }),
            RaisedButton(
                child: Text("回调2"),
                onPressed: (){
                  Navigator.pop(context, '回调222222222222222');
            })
          ],
        ),
      ),
    );
  }

}

