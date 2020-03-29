import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart' show Cart;
import '../widgets/cart_item.dart' as ci;
import '../provider/orders.dart';

class CartOverviewScreen extends StatelessWidget {
  static const routeNamed = '/cart-overview-screen';

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cartItem.totalPrice}',
                        style: Theme.of(context).primaryTextTheme.title),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('ORDER NOW!'),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cartItem.items.values.toList(), cartItem.totalPrice);
                      cartItem.clearCart();
                    },
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => ci.CartItems(
                id: cartItem.items.values.toList()[i].id,
                ProdId: cartItem.items.keys.toList()[i],
                title: cartItem.items.values.toList()[i].title,
                price: cartItem.items.values.toList()[i].price,
                quantity: cartItem.items.values.toList()[i].quantity,
              ),
              itemCount: cartItem.items.length,
            ),
          )
        ],
      ),
    );
  }
}
