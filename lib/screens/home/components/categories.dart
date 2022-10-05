import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../mock_data/data.dart';
import '../../../models/Product.dart';
import '../../details/details_screen.dart';
import 'item_card.dart';

class RenderCategoriesAndFoods extends StatefulWidget {
  int categoryIndex;

  RenderCategoriesAndFoods({Key? key, required this.categoryIndex})
      : super(key: key);

  @override
  State<RenderCategoriesAndFoods> createState() =>
      _RenderCategoriesAndFoodsState();
}

class _RenderCategoriesAndFoodsState extends State<RenderCategoriesAndFoods> {
  List<String> categories = ["Pizza", "Dania główne", "Zupy", "Napoje"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: SizedBox(
              height: 25,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => buildCategory(index)),
            ),
          ),
          selectedIndex == 0
              ? RenderFoods(selectedIndex: selectedIndex, products: pizzas)
              : selectedIndex == 1
                  ? RenderFoods(
                      selectedIndex: selectedIndex, products: main_courses)
                  : selectedIndex == 2
                      ? RenderFoods(
                          selectedIndex: selectedIndex, products: soups)
                      : RenderFoods(
                          selectedIndex: selectedIndex, products: drinks),
        ],
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          widget.categoryIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: kDefaultPadding / 4),
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

class RenderFoods extends StatelessWidget {
  final List<Product> products;
  final int selectedIndex;

  const RenderFoods(
      {Key? key, required this.products, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) => Container(
          alignment: Alignment.center,
          child: ItemCard(
            product: products[index],
            press: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  selectedIndex: selectedIndex,
                  product: products[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
