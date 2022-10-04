import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/Product.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Image.asset("${product.image}"),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        color: Colors.grey[800],
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(
          width: kDefaultPadding / 2,
        )
      ],
    );
  }
}
