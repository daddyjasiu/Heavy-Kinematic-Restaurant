import 'package:flutter/material.dart';
import 'package:heavy2022/constants.dart';

import '../../../models/Product.dart';
import 'pizza_details_customization.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(product.image!),
            fit: BoxFit.fitWidth),
      ),
      child: PizzaDetailsCustomization(size: size, product: product),
    );
  }
}
