import 'package:flutter/material.dart';
import 'package:heavy2022/screens/details/components/details_customization.dart';

import '../../../models/Product.dart';

class Body extends StatelessWidget {
  final Product product;
  final int selectedIndex;

  const Body({Key? key, required this.product, required this.selectedIndex})
      : super(key: key);

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
      child: DetailsCustomization(size: size, product: product,)
    );
  }
}
