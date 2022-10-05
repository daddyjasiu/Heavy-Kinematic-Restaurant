import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';

class MainCoursesDetailsCustomization extends StatelessWidget {
  const MainCoursesDetailsCustomization({
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
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 2,
                        ),
                      ),
                      Customization(product: product),
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

  const Customization({Key? key, required this.product}) : super(key: key);

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
          const MainCoursesExtrasRadioList(),
          product.title == "Kotlet schabowy"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding / 2),
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
  const MainCoursesExtrasRadioList({Key? key}) : super(key: key);

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
            });
          },
        ),
        RadioListTile<MainCoursesExtras>(
          title: const Text('Bar sałatkowy'),
          value: MainCoursesExtras.salad_bar,
          groupValue: _extra,
          onChanged: (MainCoursesExtras? value) {
            setState(() {
              _extra = value;
            });
          },
        ),
        RadioListTile<MainCoursesExtras>(
          title: const Text('Zestaw sosów'),
          value: MainCoursesExtras.extra_sauces,
          groupValue: _extra,
          onChanged: (MainCoursesExtras? value) {
            setState(() {
              _extra = value;
            });
          },
        ),
      ],
    );
  }
}
