import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';
class ProductDetailScreen extends StatelessWidget {
  static const namedRoute = '/product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final prodid = ModalRoute.of(context).settings.arguments as String;
      final loadedProducts = Provider.of<ProductsProvider>(context).getProductsById(prodid);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.title),
      ),
    );
  }
}
