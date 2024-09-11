import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';
import 'package:flutter_ecommerce/utilities/api_path.dart';

abstract class ProductDetailsServices {
  Future<Product> getProductDetails(String productId);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<Product> getProductDetails(String productId) async =>
      await firestoreServices.getDocument(
        path: ApiPath.product(productId),
        builder: (data, documentId) => Product.fromMap(data, documentId),
      );
}
