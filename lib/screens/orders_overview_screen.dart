import 'package:flutter/material.dart';
import 'package:fluttershopapp/widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import '../provider/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersOverviewScreen extends StatelessWidget {
  static const routeArgs = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context,listen: false).getandSetOrders(),
        builder: (ctx, datasnapshop) {
          if (datasnapshop.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (datasnapshop.error != null) {
            return Center(
              child: Text('An Error Occured'),
            );
          }
          else if(datasnapshop.data == null)
            {
              return Center(child: Text('No Data Found'),);
            }
          else {
            return Consumer<Orders>(
              builder: (ctx, order, child) {
                return ListView.builder(
                  itemBuilder: (ctx, i) => OrderItems(order.items[i]),
                  //passing whole order as constructor args.
                  itemCount: order.items.length,
                );
              },
            );
          }
        },
      ),
      drawer: MainDrawer(),
    );
  }
}
