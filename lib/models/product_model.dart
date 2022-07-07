 
class Product {
  final String id;
  final String title;
  final int price;
  final String imageUrl;
  final int discount;
  final String category;
  final int? rate;
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.discount = 0,
    this.category = 'Other',
    this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'discount': discount,
      'category': category,
      'rate': rate,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      title: map['title'] as String,
      price: map['price'] as int,
      imageUrl: map['imageUrl'] as String,
      discount: map['discount'] as int,
      category: map['category'] as String,
      rate: map['rate'] as int,
    );
  }
}

