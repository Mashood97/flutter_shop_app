import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const namedRoute = '/product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final prodid = ModalRoute.of(context).settings.arguments as String;
    final loadedProducts =
        Provider.of<ProductsProvider>(context).getProductsById(prodid);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              width: double.infinity,
              child: Image.network(
                loadedProducts.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${loadedProducts.price}',
              style: Theme.of(context).textTheme.title.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                loadedProducts.description,
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 25,
                      letterSpacing: 1,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
