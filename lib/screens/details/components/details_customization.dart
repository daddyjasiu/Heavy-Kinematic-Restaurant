import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';

double? totalPrice = 0;
double? extrasPrice = 0;
double? pizzaDoughPrice = 0;

class DetailsCustomization extends StatelessWidget {
  const DetailsCustomization({
    Key? key,
    required this.size,
    required this.product,
  }) : super(key: key);

  final Size size;
  final Product product;

  @override
  Widget build(BuildContext context) {
    totalPrice = 0;
    extrasPrice = 0;
    pizzaDoughPrice = 0;
    return ListView(
      children: <Widget>[
        SizedBox(
          height: size.height * 1.1,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: size.height * 0.45),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width / 3),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: kDefaultPadding, left: kDefaultPadding / 2),
                        child: Text(
                          product.title!,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: kDefaultPadding,
                                left: kDefaultPadding / 2,
                                bottom: kDefaultPadding),
                            child: Text(
                              "${product.price!} zł",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                    color: Colors.grey[900],
                                  ),
                            ),
                          ),
                          const Spacer(),
                          FloatingActionButton(
                            onPressed: () {
                              totalPrice = product.price! + extrasPrice! + pizzaDoughPrice!;
                              debugPrint("$totalPrice");
                            },
                            child: const Icon(Icons.add_shopping_cart_outlined),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: kDefaultPadding),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 2,
                        ),
                      ),
                      Customization(product: product, totalPrice: totalPrice),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Customization extends StatelessWidget {
  final Product product;
  final double? totalPrice;

  const Customization(
      {Key? key, required this.product, required this.totalPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          product.category == "pizza" || product.category == "main_courses"
              ? Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding / 2),
                  child: Text(
                    "Dodatki:",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.grey[900],
                        ),
                  ),
                )
              : Container(),
          product.category == "pizza"
              ? PizzaExtrasRadioList(
                  product: product,
                )
              : product.category == "main_courses"
                  ? MainCoursesExtrasRadioList(
                      product: product,
                    )
                  : Container(),
          product.category == "main_courses" &&
                  product.title == "Kotlet schabowy"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: kDefaultPadding, left: kDefaultPadding / 2),
                      child: Text(
                        "Podawany z:",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Colors.grey[900],
                            ),
                      ),
                    ),
                    const PorkChopExtrasRadioList(),
                  ],
                )
              : product.category == "pizza"
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: kDefaultPadding, left: kDefaultPadding / 2),
                      child: Text(
                        "Modyfikacje ciasta:",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Colors.grey[900],
                            ),
                      ),
                    )
                  : Container(),
          product.category == "pizza"
              ? PizzaDoughRadioList(
                  product: product,
                )
              : Container(),
        ],
      ),
    );
  }
}

enum PorkChopExtras {
  potatoes,
  fries,
  rice,
}

class PorkChopExtrasRadioList extends StatefulWidget {
  const PorkChopExtrasRadioList({Key? key}) : super(key: key);

  @override
  State<PorkChopExtrasRadioList> createState() =>
      _PorkChopExtrasRadioListState();
}

class _PorkChopExtrasRadioListState extends State<PorkChopExtrasRadioList> {
  PorkChopExtras? _extra = PorkChopExtras.potatoes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<PorkChopExtras>(
          title: const Text('Ziemniakami'),
          value: PorkChopExtras.potatoes,
          groupValue: _extra,
          onChanged: (PorkChopExtras? value) {
            setState(() {
              _extra = value;
            });
          },
        ),
        RadioListTile<PorkChopExtras>(
          title: const Text('Frytkami'),
          value: PorkChopExtras.fries,
          groupValue: _extra,
          onChanged: (PorkChopExtras? value) {
            setState(() {
              _extra = value;
            });
          },
        ),
        RadioListTile<PorkChopExtras>(
          title: const Text('Ryżem'),
          value: PorkChopExtras.rice,
          groupValue: _extra,
          onChanged: (PorkChopExtras? value) {
            setState(() {
              _extra = value;
            });
          },
        ),
      ],
    );
  }
}

enum MainCoursesExtras {
  none,
  salad_bar,
  extra_sauces,
}

class MainCoursesExtrasRadioList extends StatefulWidget {
  final Product product;

  MainCoursesExtrasRadioList({Key? key, required this.product})
      : super(key: key);

  @override
  State<MainCoursesExtrasRadioList> createState() =>
      _MainCoursesExtrasRadioListState();
}

class _MainCoursesExtrasRadioListState
    extends State<MainCoursesExtrasRadioList> {
  MainCoursesExtras? _extra = MainCoursesExtras.none;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<MainCoursesExtras>(
          title: const Text('Brak'),
          value: MainCoursesExtras.none,
          groupValue: _extra,
          onChanged: (MainCoursesExtras? value) {
            setState(() {
              _extra = value;
              pizzaDoughPrice = 0.0;
              extrasPrice = 0.0;
            });
          },
        ),
        RadioListTile<MainCoursesExtras>(
          title: Row(
            children: const [
              Text('Bar sałatkowy'),
              Spacer(),
              Text(
                "+ 7zł",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          value: MainCoursesExtras.salad_bar,
          groupValue: _extra,
          onChanged: (MainCoursesExtras? value) {
            setState(() {
              _extra = value;
              extrasPrice = 7.0;
            });
          },
        ),
        RadioListTile<MainCoursesExtras>(
          title: Row(
            children: const [
              Text('Zestaw sosów'),
              Spacer(),
              Text(
                "+ 5.5zł",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          value: MainCoursesExtras.extra_sauces,
          groupValue: _extra,
          onChanged: (MainCoursesExtras? value) {
            setState(() {
              _extra = value;
              extrasPrice =  5.5;
            });
          },
        ),
      ],
    );
  }
}

enum PizzaExtras { none, double_cheese, salami, ham, mushrooms, chicken }

class PizzaExtrasRadioList extends StatefulWidget {
  final Product product;

  const PizzaExtrasRadioList({Key? key, required this.product})
      : super(key: key);

  @override
  State<PizzaExtrasRadioList> createState() => _PizzaExtrasRadioListState();
}

class _PizzaExtrasRadioListState extends State<PizzaExtrasRadioList> {
  PizzaExtras? _extra = PizzaExtras.none;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<PizzaExtras>(
          title: const Text('Brak'),
          value: PizzaExtras.none,
          groupValue: _extra,
          onChanged: (PizzaExtras? value) {
            setState(() {
              _extra = value;
              extrasPrice = 0.0;
            });
          },
        ),
        RadioListTile<PizzaExtras>(
          title: Row(
            children: const [
              Text('Podwójny ser'),
              Spacer(),
              Text(
                "+ 2.5zł",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          value: PizzaExtras.double_cheese,
          groupValue: _extra,
          onChanged: (PizzaExtras? value) {
            setState(() {
              _extra = value;
              extrasPrice = 2.5;
            });
          },
        ),
        RadioListTile<PizzaExtras>(
          title: Row(
            children: const [
              Text('Salami'),
              Spacer(),
              Text(
                "+ 2.5zł",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          value: PizzaExtras.salami,
          groupValue: _extra,
          onChanged: (PizzaExtras? value) {
            setState(() {
              _extra = value;
              extrasPrice = 2.5;
            });
          },
        ),
        RadioListTile<PizzaExtras>(
          title: Row(
            children: const [
              Text('Szynka'),
              Spacer(),
              Text(
                "+ 2.5zł",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          value: PizzaExtras.ham,
          groupValue: _extra,
          onChanged: (PizzaExtras? value) {
            setState(() {
              _extra = value;
              extrasPrice = 2.5;
            });
          },
        ),
        RadioListTile<PizzaExtras>(
          title: Row(
            children: const [
              Text('Pieczarki'),
              Spacer(),
              Text(
                "+ 2.5zł",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          value: PizzaExtras.mushrooms,
          groupValue: _extra,
          onChanged: (PizzaExtras? value) {
            setState(() {
              _extra = value;
              extrasPrice = 2.5;
            });
          },
        ),
        RadioListTile<PizzaExtras>(
          title: Row(
            children: const [
              Text('Kurczak'),
              Spacer(),
              Text(
                "+ 2.5zł",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          value: PizzaExtras.chicken,
          groupValue: _extra,
          onChanged: (PizzaExtras? value) {
            setState(() {
              _extra = value;
              extrasPrice = 2.5;
            });
          },
        ),
      ],
    );
  }
}

enum PizzaDough { none, gluten_free, cheese_filled }

class PizzaDoughRadioList extends StatefulWidget {
  final Product product;

  const PizzaDoughRadioList({Key? key, required this.product})
      : super(key: key);

  @override
  State<PizzaDoughRadioList> createState() => _PizzaDoughRadioListState();
}

class _PizzaDoughRadioListState extends State<PizzaDoughRadioList> {
  PizzaDough? _dough = PizzaDough.none;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<PizzaDough>(
          title: const Text('Klasyczne'),
          value: PizzaDough.none,
          groupValue: _dough,
          onChanged: (PizzaDough? value) {
            setState(() {
              _dough = value;
              pizzaDoughPrice = 0.0;
            });
          },
        ),
        RadioListTile<PizzaDough>(
          title: Row(
            children: const [
              Text('Bezglutenowe'),
              Spacer(),
              Text(
                "+ 4zł",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          value: PizzaDough.gluten_free,
          groupValue: _dough,
          onChanged: (PizzaDough? value) {
            setState(() {
              _dough = value;
              pizzaDoughPrice = 4.0;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kDefaultPadding),
          child: RadioListTile<PizzaDough>(
            title: Row(
              children: const [
                Text('Serowe brzegi'),
                Spacer(),
                Text(
                  "+ 6zł",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            value: PizzaDough.cheese_filled,
            groupValue: _dough,
            onChanged: (PizzaDough? value) {
              setState(() {
                _dough = value;
                pizzaDoughPrice = 6.0;
              });
            },
          ),
        ),
      ],
    );
  }
}
