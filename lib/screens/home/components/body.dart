import 'package:flutter/material.dart';
import 'package:heavy2022/constants.dart';
import 'package:heavy2022/screens/details/details_screen.dart';

import '../../../mock_data/data.dart';
import 'categories.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: kDefaultPadding / 1.2),
          child: Text(
            "Heavy Kinematic Restaurant",
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Categories(),
        Expanded(
            child: GridView.builder(
          itemCount: pizzas.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.90,
            mainAxisSpacing: kDefaultPadding / 2,
            crossAxisSpacing: 0,
          ),
          itemBuilder: (context, index) => Container(
            alignment: Alignment.center,
            child: ItemCard(
              product: pizzas[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(product: pizzas[index]),
                ),
              ),
            ),
          ),
        )),
      ],
    );
  }
}
