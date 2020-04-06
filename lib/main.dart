import 'package:flutter/material.dart';
import 'package:fluttershopapp/screens/orders_overview_screen.dart';
import './provider/orders.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import 'package:provider/provider.dart';
import './provider/products_provider.dart';
import './provider/cart.dart';
import './screens/user_products_screen.dart';
import './screens/cart_overview_screen.dart';
import './screens/edit_product.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.namedRoute: (ctx) => ProductDetailScreen(),
          CartOverviewScreen.routeNamed: (ctx) => CartOverviewScreen(),
          OrdersOverviewScreen.routeArgs: (ctx) => OrdersOverviewScreen(),
          UserProductsScreen.routeArgs: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
