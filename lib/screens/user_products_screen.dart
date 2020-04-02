import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';
import '../widgets/main_drawer.dart';
import '../widgets/user_products_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeArgs = '/user-products-screen';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon (Icons.add),
            onPressed: (){},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (ctx,i)=>Column(
            children: <Widget>[
              UserProductsItem(productData.items[i].title,productData.items[i].imageUrl),
            Divider(),
            ],
          ),
          itemCount: productData.items.length,
        ),
      ),

      drawer: MainDrawer(),
    );
  }
}
