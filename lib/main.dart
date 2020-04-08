import 'package:flutter/material.dart';
import 'package:fluttershopapp/provider/auth.dart';
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
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          builder: (ctx, auth, previousProducts) => ProductsProvider(auth.token,auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          builder: (ctx, auth, prevorders) =>
              Orders(auth.token, prevorders == null ? [] : prevorders.items),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'),
          home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.namedRoute: (ctx) => ProductDetailScreen(),
            CartOverviewScreen.routeNamed: (ctx) => CartOverviewScreen(),
            OrdersOverviewScreen.routeArgs: (ctx) => OrdersOverviewScreen(),
            UserProductsScreen.routeArgs: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
