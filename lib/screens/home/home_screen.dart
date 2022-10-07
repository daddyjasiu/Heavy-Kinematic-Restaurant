import 'package:flutter/material.dart';
import 'package:heavy2022/constants.dart';
import 'package:heavy2022/screens/order_history/order_history_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        onPressed: () {
          _showMyDialog(context);
        },
        icon: Icon(
          Icons.more_horiz,
          color: Colors.grey[800],
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderHistoryScreen(),
              ),
            );
          },
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
            Icons.shopping_cart_outlined,
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

Future<void> _showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      TextEditingController nameController = TextEditingController();
      TextEditingController emailController = TextEditingController();

      return AlertDialog(
        title: const Text('Uzupełnij swoje dane'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Twoje imię',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Twój e-mail'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Zapisz'),
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty) {
                setSharedPreferences(nameController.text, emailController.text);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Podaj swoje imię i e-mail.")));
              }
            },
          ),
        ],
      );
    },
  );
}

Future setSharedPreferences(userName, userEmail) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('user_name', userName);
  prefs.setString('user_email', userEmail);
}
