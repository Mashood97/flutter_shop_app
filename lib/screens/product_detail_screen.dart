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
//      appBar: AppBar(
//        title: Text(loadedProducts.title),
//      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                color: Theme.of(context).primaryColor,
                child: Text(loadedProducts.title),
              ),
              background: Hero(
                tag: loadedProducts.id,
                child: Image.network(
                  loadedProducts.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              Text(
                '\$${loadedProducts.price}',
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
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
              SizedBox(
                height: 600,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
