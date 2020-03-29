import 'dart:math';
import 'package:flutter/material.dart';
import '../provider/orders.dart';
import 'package:intl/intl.dart';

class OrderItems extends StatefulWidget {
  final OrderItem orders;

  OrderItems(this.orders);

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.orders.amount}'),
            subtitle: Text(
              DateFormat.yMMMEd().format(widget.orders.dateTime),
            ),
            trailing: IconButton(
              icon: !_expanded
                  ? Icon(Icons.expand_more)
                  : Icon(Icons.expand_less),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.orders.products.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.orders.products
                    .map((prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              prod.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${prod.quantity}x \$${prod.price}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
