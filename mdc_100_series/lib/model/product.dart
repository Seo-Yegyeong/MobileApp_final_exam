class Product {
  const Product({
    required this.name,
    required this.price,
    required this.description,
  });

  final String name;
  final String price;
  final String description;

  Product.fromJson(Map<String, Object?> json)
  : this(
    name: json['name']! as String,
    price: json['price']! as String,
    description: json['description']! as String,
  );

  Map<String, Object?> toJson(){
    return{
      'name' : name,
      'price' : price,
      'description' : description,
    };
  }
}
