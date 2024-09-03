import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';
import 'package:flutter_ecommerce/utilities/api_path.dart';

abstract class HomeServices {
  Future<List<Product>> getSalesProducts();
  Future<List<Product>> getNewProducts();
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<List<Product>> getNewProducts() async =>
      await firestoreServices.getCollection(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data, documentId),
      );

  @override
  Future<List<Product>> getSalesProducts() async =>
      await firestoreServices.getCollection(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data, documentId),
        queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
      );
}
