import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heavy2022/constants.dart';
import 'package:heavy2022/models/OrderHistory.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../database/db.dart';
import '../../../models/CartProduct.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<CartProduct> cartProducts;
  bool isLoading = false;

  TextEditingController orderConcerns = TextEditingController();

  late String? userName;
  late String? userEmail;

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString("user_name");
    userEmail = prefs.getString("user_email");
  }

  @override
  void initState() {
    super.initState();
    refreshCart();
    getSharedPrefs();
  }

  @override
  void dispose() {
    //CartDatabase.instance.close();
    super.dispose();
  }

  Future refreshCart() async {
    setState(() => isLoading = true);

    cartProducts =
        (await SQFLiteDB.instance.readCartProducts()).reversed.toList();

    setState(() => isLoading = false);
  }

  Future sendEmail({
    required String receiverName,
    required String receiverEmail,
    required String senderEmail,
    required String emailSubject,
    required String order,
    required String concerns,
    required String totalPrice,
  }) async {
    final serviceId = 'service_afcv3w9';
    final templateId = 'template_gndlqi8';
    final userId = '6lX92xHDoWMp6poEN';

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'receiver_name': receiverName,
          'receiver_email': receiverEmail,
          'sender_email': senderEmail,
          'email_subject': emailSubject,
          'order': order,
          'concerns': concerns,
          'total_price': totalPrice,
        },
      }),
    );

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: isLoading
              ? const CircularProgressIndicator()
              : cartProducts.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding,
                          horizontal: kDefaultPadding),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: kDefaultPadding / 2,
                                  horizontal: kDefaultPadding / 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(2.0,
                                        2.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: kDefaultPadding,
                                    horizontal: kDefaultPadding / 4),
                                child: Text(
                                  'Twój koszyk jest pusty!\nWybierz produkty z menu i wróć tutaj aby złożyć zamówienie.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                  : buildCartProducts(),
        ),
      ],
    );
  }

  Widget buildCartProducts() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: cartProducts.length + 1,
      itemBuilder: (context, index) {
        if (index != cartProducts.length) {
          final cartProduct = cartProducts[index];

          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset("${cartProduct.image}"),
                    ),
                    title: Text("${cartProduct.title}"),
                    subtitle: Text(
                      '${cartProduct.price} zł',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2,
                        horizontal: kDefaultPadding),
                    child: Text(
                      'Dodatki:',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: kDefaultPadding / 1.2),
                    child: Row(
                      children: [
                        Text(
                          '${cartProduct.extras}',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            SQFLiteDB.instance
                                .deleteCartProduct(cartProduct.id!);
                            refreshCart();

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Produkt usunięty z koszyka.")));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue[400]!)),
                          child:
                              const Icon(Icons.remove_shopping_cart_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          double totalPrice = 0;

          for (var product in cartProducts) {
            totalPrice += product.price!;
          }

          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        top: kDefaultPadding,
                        left: kDefaultPadding,
                        right: kDefaultPadding),
                    child: Text(
                      "Uwagi do zamówienia: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 4,
                        horizontal: kDefaultPadding),
                    child: TextField(
                      controller: orderConcerns,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 4,
                        horizontal: kDefaultPadding / 2),
                    child: ElevatedButton(
                      onPressed: () {
                        if (userName != null && userEmail != null) {
                          SQFLiteDB.instance.deleteAllCartProducts();

                          for (var element in cartProducts) {
                            SQFLiteDB.instance.createOrderHistory(OrderHistory(
                              id: element.id,
                              image: element.image,
                              title: element.title,
                              price: element.price,
                              description: element.description,
                              category: element.category,
                              extras: element.extras,
                            ));
                          }

                          refreshCart();

                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Zamówienie złożone!\n\nSzczegóły zostały wysłane na adres mailowy.")));

                          String order = '';
                          int orderNum = 1;
                          for (var element in cartProducts) {
                            order += '''
                            ${orderNum++}.<br/>
                            ${element.title}<br/>
                            Cena: ${element.price}<br/>
                            Dodatki: ${element.extras}<br/><br/>
                        ''';
                          }

                          sendEmail(
                            receiverName: "$userName",
                            receiverEmail: "$userEmail",
                            senderEmail: "heavykinematicrestaurant@noreply.com",
                            emailSubject:
                                "Your Heavy Kinematic Restaurant order",
                            order: order,
                            concerns: orderConcerns.text,
                            totalPrice: "${totalPrice.toString()} zł",
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Uzupełnij swoje dane w ustawieniach na ekranie głównym.")));
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue[400]!),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: kDefaultPadding / 2),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "${cartProducts.length}",
                                  style: const TextStyle(
                                      color: Colors.blue, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "Do zapłaty: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const Spacer(),
                          Text(
                            "$totalPrice zł",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
