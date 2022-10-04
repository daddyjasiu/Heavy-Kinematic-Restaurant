import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 1.1,
            child: Stack(
              children: <Widget>[
                Container(
                  constraints: const BoxConstraints.expand(),
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
                              top: kDefaultPadding, left: kDefaultPadding / 2),
                          child: Text(
                            "${product.price!} zł",
                            style:
                                Theme.of(context).textTheme.headline5?.copyWith(
                                      color: Colors.grey[900],
                                    ),
                          ),
                        ),
                        const Customization()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Customization extends StatelessWidget {
  const Customization({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: kDefaultPadding, left: kDefaultPadding / 2),
            child: Text(
              "Dodatki:",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.grey[900],
                  ),
            ),
          ),
          Column(
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF356C95))),
              ),
            ],
          ),
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
        ],
      ),
    );
  }
}
