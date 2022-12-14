import 'package:flutter/material.dart';
import 'package:heavy2022/constants.dart';

import 'categories.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  final int _categoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    ?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[900]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1.5,
                color: kTextLightColor,
              ),
            ),
          ],
        ),
        RenderCategoriesAndFoods(
          categoryIndex: _categoryIndex,
        ),
      ],
    );
  }
}
