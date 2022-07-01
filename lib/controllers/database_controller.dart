import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';
import 'package:flutter_ecommerce/utilities/api_path.dart';

abstract class Database {
  Stream<List<Product>> salesProductsStream();
  Stream<List<Product>> newProductsStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreServices.instance;

  FirestoreDatabase(this.uid);

  @override
  Stream<List<Product>> salesProductsStream() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
      );

  @override
  Stream<List<Product>> newProductsStream() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );
}
