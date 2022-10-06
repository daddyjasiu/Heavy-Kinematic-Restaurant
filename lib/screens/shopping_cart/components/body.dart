import 'package:flutter/material.dart';
import 'package:heavy2022/constants.dart';

import '../../../database/cart_db.dart';
import '../../../models/CartProduct.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<CartProduct> cartProducts;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshCart();
  }

  @override
  void dispose() {
    //CartDatabase.instance.close();
    super.dispose();
  }

  Future refreshCart() async {
    setState(() => isLoading = true);

    cartProducts = await CartDatabase.instance.readCartProducts();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: isLoading
              ? const CircularProgressIndicator()
              : cartProducts.isEmpty
                  ? const Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
      ],
    );
  }

  Widget buildNotes() => ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          final cartProduct = cartProducts[index];

          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Image.asset("${cartProduct.image}"),
                  title: Text("${cartProduct.title}"),
                  subtitle: Text(
                    '${cartProduct.price} zł',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding/2, horizontal: kDefaultPadding),
                  child: Text(
                    'Dodatki:',
                    style: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Text(
                    '${cartProduct.extras}',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Perform some action
                      },
                      child: const Text('ACTION 1'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
}
