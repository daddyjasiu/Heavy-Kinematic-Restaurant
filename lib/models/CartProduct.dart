class CartProduct {
  final String? image, title, description, category;
  final double? price, id;
  final List<String>? pizzaExtras;
  final List<String>? pizzaDough;
  final List<String>? mainCourseExtras;
  final List<String>? porkChopSideExtra;

  CartProduct({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.category,
    this.pizzaExtras,
    this.pizzaDough,
    this.mainCourseExtras,
    this.porkChopSideExtra,
  });
}