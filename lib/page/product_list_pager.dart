import 'package:flutter/material.dart';

class ProductPager extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: '商品列表',
      home: new ProductList(products: List.generate(20, (i)=>Product('商品$i', '╭︿︿︿╮ {/ o  o /}   ( (oo) )     ︶︶︶汤饭，编号为$i')),
    )
    );
  }
}

class Product {
  final String title; //商品标题
  final String description; //商品描述
  Product(this.title, this.description);
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({Key key, @required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表'),
      ),
      // list 列表构建
      body: ListView.builder(
          //列表长度
          itemCount: products.length,
          // 列表标题和点击事件
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(products[index].title),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new ProductDetail(product: products[index])));
              },
            );
          }),
    );
  }
}

class ProductDetail extends StatelessWidget{
  final Product product;
  ProductDetail({Key key, @required this.product}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('${product.title}'),
      ),
      body: Center(child: Text('${product.description}'),),
    );
  }

}