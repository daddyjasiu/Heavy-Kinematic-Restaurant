import 'package:flutter/material.dart';

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
        Center(
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
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          final cartProduct = cartProducts[index];

          return GestureDetector(
            onTap: () async {
              // await Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => NoteDetailPage(noteId: note.id!),
              // ));
              //
              // refreshCart();
            },
            child: Text("${cartProduct.title}"),
          );
        },
      );
}
