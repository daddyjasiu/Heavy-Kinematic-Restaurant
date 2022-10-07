import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function() press;

  const ItemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, //add this
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      product.image!,
                      fit: BoxFit.cover, // add this
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
                  child: Text(
                    product.title!,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Text(
                  "${product.price!.toInt()} zł",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
