import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String ProdId;
  final double price;
  final int quantity;
  final String title;

  CartItems({this.id, this.ProdId, this.title, this.price, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) {
        Provider.of<Cart>(context,listen: false).removeItem(ProdId);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.all(10),
        color: Theme.of(context).accentColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(child: Text('\$${price.toStringAsFixed(0)}')),
              ),
            ),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
