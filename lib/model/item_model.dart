class Item {
  String name;
  int qty;
  double price;

  Item({
    required this.name,
    required this.qty,
    required this.price,
  });

  List<String> toList() => [
        name,
        "$qty",
        "Rs: ${price.toStringAsFixed(1)}",
        (price * qty).toStringAsFixed(1),
      ];

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'qty': qty,
      'price': price,
    };
  }

  // JSON deserialization
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      qty: json['qty'],
      price: json['price'],
    );
  }

  // Override toString
  @override
  String toString() {
    return 'Item(name: $name, qty: $qty, price: ₨ ${price.toStringAsFixed(1)}, total: ₨ ${(price * qty).toStringAsFixed(1)})';
  }
}
