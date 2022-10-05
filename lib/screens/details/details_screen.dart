import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/Product.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {

  final Product product;
  final int selectedIndex;

  const DetailsScreen({Key? key, required this.product, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
        appBar: buildAppBar(context),
      body: Body(
        selectedIndex: selectedIndex,
        product: product,
      ),
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
