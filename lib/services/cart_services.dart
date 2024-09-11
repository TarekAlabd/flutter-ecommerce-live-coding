import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';
import 'package:flutter_ecommerce/utilities/api_path.dart';

abstract class CartServices {
  Future<void> addProductToCart(String userId, AddToCartModel cartProduct);
  Future<List<AddToCartModel>> getCartProducts(String userId);
}

class CartServicesImpl implements CartServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<void> addProductToCart(
          String userId, AddToCartModel cartProduct) async =>
      await firestoreServices.setData(
        path: ApiPath.addToCart(userId, cartProduct.id),
        data: cartProduct.toMap(),
      );

  @override
  Future<List<AddToCartModel>> getCartProducts(String userId) async =>
      await firestoreServices.getCollection(
        path: ApiPath.myProductsCart(userId),
        builder: (data, documentId) => AddToCartModel.fromMap(data, documentId),
      );
}
