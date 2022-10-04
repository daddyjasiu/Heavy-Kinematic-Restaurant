import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';

class PizzaDetailsCustomization extends StatelessWidget {
  const PizzaDetailsCustomization({
    Key? key,
    required this.size,
    required this.product,
  }) : super(key: key);

  final Size size;
  final Product product;

  @override
  Widget build(BuildContext context) {
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: kDefaultPadding,
                            left: kDefaultPadding / 2,
                            bottom: kDefaultPadding),
                        child: Text(
                          "${product.price!} zł",
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    color: Colors.grey[900],
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: kDefaultPadding),
                        child: Divider(color: Colors.grey[800], thickness: 1,),
                      ),

                      const Customization(),
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
  const Customization({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: Text(
              "Dodatki:",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.grey[900],
                  ),
            ),
          ),
          const PizzaExtrasRadioList(),
          Padding(
            padding: const EdgeInsets.only(
                top: kDefaultPadding, left: kDefaultPadding / 2),
            child: Text(
              "Ciasto:",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.grey[900],
                  ),
            ),
          ),
          const PizzaDoughRadioList()
        ],
      ),
    );
  }
}

enum PizzaExtras { none, double_cheese, salami, ham, mushrooms, chicken }

class PizzaExtrasRadioList extends StatefulWidget {
  const PizzaExtrasRadioList({Key? key}) : super(key: key);

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
            });
          },
        ),
        RadioListTile<PizzaExtras>(
          title: const Text('Podwójny ser'),
          value: PizzaExtras.double_cheese,
          groupValue: _extra,
          onChanged: (PizzaExtras? value) {
            setState(() {
              _extra = value;
            });
          },
        ),
        RadioListTile<PizzaExtras>(
          title: const Text('Salami'),
          value: PizzaExtras.salami,
          groupValue: _extra,
          onChanged: (PizzaExtras? value) {
            setState(() {
              _extra = value;
            });
          },
        ),
        RadioListTile<PizzaExtras>(
          title: const Text('Szynka'),
          value: PizzaExtras.ham,
          groupValue: _extra,
          onChanged: (PizzaExtras? value) {
            setState(() {
              _extra = value;
            });
          },
        ),
        RadioListTile<PizzaExtras>(
          title: const Text('Pieczarki'),
          value: PizzaExtras.mushrooms,
          groupValue: _extra,
          onChanged: (PizzaExtras? value) {
            setState(() {
              _extra = value;
            });
          },
        ),
        RadioListTile<PizzaExtras>(
          title: const Text('Kurczak'),
          value: PizzaExtras.chicken,
          groupValue: _extra,
          onChanged: (PizzaExtras? value) {
            setState(() {
              _extra = value;
            });
          },
        ),
      ],
    );
  }
}

enum PizzaDough { none, gluten_free, cheese_filled }

class PizzaDoughRadioList extends StatefulWidget {
  const PizzaDoughRadioList({Key? key}) : super(key: key);

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
            });
          },
        ),
        RadioListTile<PizzaDough>(
          title: const Text('Bezglutenowe'),
          value: PizzaDough.gluten_free,
          groupValue: _dough,
          onChanged: (PizzaDough? value) {
            setState(() {
              _dough = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kDefaultPadding),
          child: RadioListTile<PizzaDough>(
            title: const Text('Serowe brzegi'),
            value: PizzaDough.cheese_filled,
            groupValue: _dough,
            onChanged: (PizzaDough? value) {
              setState(() {
                _dough = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
