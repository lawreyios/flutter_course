import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'productCard.dart';
import 'package:flutter_course/scoped-models/main.dart';
import 'package:flutter_course/models/product.dart';

class Products extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildProductList(model.displayedProducts);
      },
     );
  }

  Widget _buildProductList(List<Product> products) {
    Widget productCard = Center(child: Text("No Products Found"));
    if (products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    }
    return productCard;
  }
}
