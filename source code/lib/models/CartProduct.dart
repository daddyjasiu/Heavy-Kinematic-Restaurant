class CartProduct {
  final int? id;
  final String? image, title, description, category;
  final double? price;
  final String? extras;

  CartProduct({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.category,
    this.extras,
  });

  Map<String, Object?> toJson() => {
        CartProductFields.id: id,
        CartProductFields.image: image,
        CartProductFields.title: title,
        CartProductFields.price: price,
        CartProductFields.description: description,
        CartProductFields.category: category,
        CartProductFields.extras: extras,
      };

  static CartProduct fromJson(Map<String, Object?> json) => CartProduct(
      id: json[CartProductFields.id] as int?,
      image: json[CartProductFields.image] as String?,
      title: json[CartProductFields.title] as String?,
      price: json[CartProductFields.price] as double?,
      description: json[CartProductFields.description] as String?,
      category: json[CartProductFields.category] as String?,
      extras: json[CartProductFields.extras] as String?,
  );

  CartProduct copy({
    int? id,
    String? image,
    String? title,
    String? description,
    String? category,
    double? price,
    String? extras,
  }) =>
      CartProduct(
        id: id ?? this.id,
        image: image ?? this.image,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        price: price ?? this.price,
        extras: extras ?? this.extras,
      );
}

final String tableCartProduct = 'cart_product';

class CartProductFields {
  static final List<String> values = [
    id,
    image,
    title,
    description,
    category,
    price,
    extras,
  ];

  static final String id = "_id";
  static final String image = "image";
  static final String title = "title";
  static final String description = "description";
  static final String category = "category";
  static final String price = "price";
  static final String extras = "extras";
}
