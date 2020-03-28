import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';
import '../provider/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showfav;

  ProductsGrid(this.showfav);

  @override
  Widget build(BuildContext context) {
    final providerProducts = Provider.of<ProductsProvider>(context);
    final productData =
        showfav ? providerProducts.getFavourite : providerProducts.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: productData[i],
        child: ProductItem(
//        providerProducts[i].id,
//        providerProducts[i].title,
//        providerProducts[i].imageUrl,
            ),
      ),
      itemCount: productData.length,
    );
  }
}
