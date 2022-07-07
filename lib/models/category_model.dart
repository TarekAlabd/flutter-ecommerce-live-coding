class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category(
    this.id,
    this.name,
    this.imageUrl,
  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map, String documentId) {
    return Category(
      documentId,
      map['name'] as String,
      map['imageUrl'] as String,
    );
  }
}
