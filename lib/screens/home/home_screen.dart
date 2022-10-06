import 'package:flutter/material.dart';
import 'package:heavy2022/constants.dart';

import '../shopping_cart/shopping_cart_screen.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.more_horiz,
          color: Colors.grey[800],
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.history,
            color: Colors.grey[800],
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShoppingCartScreen(),
              ),
            );
          },
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
