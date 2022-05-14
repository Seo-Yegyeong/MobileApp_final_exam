class Product {
  const Product({
    required this.name,
    required this.price,
    required this.description,
    required this.writer,
    required this.popular,
  });

  final String name;
  final String price;
  final String description;
  final String? writer;
  final int popular;

  Product.fromJson(Map<String, Object?> json)
  : this(
    name: json['name']! as String,
    price: json['price']! as String,
    description: json['description']! as String,
    writer: json['writer']! as String,
    popular: json['popular']! as int,
  );

  Map<String, Object?> toJson(){
    return{
      'name' : name,
      'price' : price,
      'description' : description,
      'writer' : writer,
      'popular' : popular,
    };
  }
}
