import 'package:flutter/material.dart';
import 'package:heavy2022/constants.dart';
import 'package:heavy2022/screens/details/details_screen.dart';

import '../../../mock_data/data.dart';
import 'categories.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  int _categoryIndex = 0;

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
        RenderCategoriesAndFoods(
          categoryIndex: _categoryIndex,
        ),
        //RenderFoods(categoryIndex: _categoryIndex),
      ],
    );
  }
}
