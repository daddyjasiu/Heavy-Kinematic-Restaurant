class OrderHistory {
  final int? id;
  final String? image, title, description, category;
  final double? price;
  final String? extras;

  OrderHistory({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.category,
    this.extras,
  });

  Map<String, Object?> toJson() => {
    OrderHistoryFields.id: id,
    OrderHistoryFields.image: image,
    OrderHistoryFields.title: title,
    OrderHistoryFields.price: price,
    OrderHistoryFields.description: description,
    OrderHistoryFields.category: category,
    OrderHistoryFields.extras: extras,
  };

  static OrderHistory fromJson(Map<String, Object?> json) => OrderHistory(
    id: json[OrderHistoryFields.id] as int?,
    image: json[OrderHistoryFields.image] as String?,
    title: json[OrderHistoryFields.title] as String?,
    price: json[OrderHistoryFields.price] as double?,
    description: json[OrderHistoryFields.description] as String?,
    category: json[OrderHistoryFields.category] as String?,
    extras: json[OrderHistoryFields.extras] as String?,
  );

  OrderHistory copy({
    int? id,
    String? image,
    String? title,
    String? description,
    String? category,
    double? price,
    String? extras,
  }) =>
      OrderHistory(
        id: id ?? this.id,
        image: image ?? this.image,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        price: price ?? this.price,
        extras: extras ?? this.extras,
      );
}

final String tableOrderHistory = 'order_history';

class OrderHistoryFields {
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
