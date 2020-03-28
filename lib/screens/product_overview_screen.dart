import 'package:flutter/material.dart';
import '../screens/cart_overview_screen.dart';
import 'package:fluttershopapp/widgets/badge.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

enum FilterFavourites {
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
//  final List<Product> loadedProduct =

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var showFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopify'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (selectedValue) {
              setState(() {
                if (selectedValue == FilterFavourites.Favourites) {
                  showFav = true;
                } else {
                  showFav = false;
                }
              });
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Show Favourites'),
                value: FilterFavourites.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterFavourites.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.getItemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartOverviewScreen.routeNamed);
              },
            ),
          ),
        ],
      ),
      body: ProductsGrid(showFav),
    );
  }
}
