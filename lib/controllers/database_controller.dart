 

import '../models/product_model.dart';
import '../services/firestore_services.dart';

abstract class Database {
  Stream<List<Product>> allProductsStream();
  Stream<List<Product>> newProductsStream();
  Stream<List<Product>> salesPproductsStream();
}

class FirestoreDatabase implements Database {
  final _service = FirestoreServices.instance;
  final String uid;
  static const String _path = 'products/';
  FirestoreDatabase(this.uid);
  @override
  Stream<List<Product>> allProductsStream() => _service.collectionsStream(
        path: _path,
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );

  @override
  Stream<List<Product>> newProductsStream() => _service.collectionsStream(
        path: _path,
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('discount', isEqualTo: 0),
      );

  @override
  Stream<List<Product>> salesPproductsStream() => _service.collectionsStream(
        path: _path,
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('discount', isGreaterThan: 0),
      );
}
