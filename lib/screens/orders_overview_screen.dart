import 'package:flutter/material.dart';
import 'package:fluttershopapp/widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import '../provider/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersOverviewScreen extends StatelessWidget {
  static const routeArgs = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItems(ordersData.items[i]),
        //passing whole order as constructor args.
        itemCount: ordersData.items.length,
      ),
      drawer: MainDrawer(),
    );
  }
}
