import 'package:flutter/material.dart';
import 'package:fluttershopapp/provider/products_provider.dart';
import 'package:fluttershopapp/widgets/main_drawer.dart';
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
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
//    Future.delayed(Duration.zero).then((_){
//      Provider.of<ProductsProvider>(context).getandsetProduct();
//
//    }); // we can use this to do work for api calling as context dont work on initstate.
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).getandsetProduct().then((_){
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopify'),
        actions: <Widget>[
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
        ],
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : ProductsGrid(showFav),
      drawer: MainDrawer(),
    );
  }
}
