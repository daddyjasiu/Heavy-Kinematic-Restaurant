import 'package:flutter/material.dart';
import 'package:heavy2022/constants.dart';
import 'package:heavy2022/models/OrderHistory.dart';

import '../../../database/db.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<OrderHistory> orderHistoryProducts;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshHistory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshHistory() async {
    setState(() => isLoading = true);

    orderHistoryProducts = (await SQFLiteDB.instance.readOrderHistory()).reversed.toList();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: isLoading
              ? const CircularProgressIndicator()
              : orderHistoryProducts.isEmpty
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
                          'Tutaj pojawią się złożone zamówienia.',
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
              : buildOrderHistory(),
        ),
      ],
    );
  }

  Widget buildOrderHistory() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: orderHistoryProducts.length + 1,
      itemBuilder: (context, index) {
        if (index != 0) {
          final orderHistory = orderHistoryProducts[index-1];

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
                      child: Image.asset("${orderHistory.image}"),
                    ),
                    title: Text("${orderHistory.title}"),
                    subtitle: Text(
                      '${orderHistory.price} zł',
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
                          '${orderHistory.extras}',
                          style:
                          TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {

          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 4,
                        horizontal: kDefaultPadding / 2),
                    child: ElevatedButton(
                      onPressed: () {
                        SQFLiteDB.instance.deleteAllOrderHistory();
                        refreshHistory();

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Historia zamówień została usunięta.")));
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
                                  "${orderHistoryProducts.length}",
                                  style: const TextStyle(
                                      color: Colors.blue, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            "Wyczyść historię zamówień",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const Spacer(),
                          const Icon(Icons.delete_forever_rounded)
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
