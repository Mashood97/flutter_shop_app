import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';
import '../widgets/main_drawer.dart';
import '../widgets/user_products_item.dart';
import '../screens/edit_product.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeArgs = '/user-products-screen';

  Future<void> _getRefreshedData(BuildContext context) async{
    await Provider.of<ProductsProvider>(context).getandsetProduct();

  }


  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()=>_getRefreshedData(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (ctx, i) => Column(
              children: <Widget>[
                UserProductsItem(
                  productData.items[i].id,
                  productData.items[i].title,
                  productData.items[i].imageUrl,
                ),
                Divider(),
              ],
            ),
            itemCount: productData.items.length,
          ),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
