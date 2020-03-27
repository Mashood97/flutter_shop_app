import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const namedRoute = '/product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(routeArgs),
      ),
    );
  }
}
