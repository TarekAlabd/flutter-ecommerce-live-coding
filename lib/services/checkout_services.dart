import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/models/delivery_method.dart';
import 'package:flutter_ecommerce/models/payment_method.dart';
import 'package:flutter_ecommerce/models/shipping_address.dart';
import 'package:flutter_ecommerce/services/auth.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';
import 'package:flutter_ecommerce/utilities/api_path.dart';

abstract class CheckoutServices {
  Future<void> setPaymentMethod(PaymentMethod paymentMethod);
  Future<void> deletePaymentMethod(PaymentMethod paymentMethod);
  Future<List<PaymentMethod>> paymentMethods();
  Future<List<ShippingAddress>> shippingAddresses(String userId);
  Future<List<DeliveryMethod>> deliveryMethods();
  Future<void> saveAddress(String userId, ShippingAddress address);
}

class CheckoutServicesImpl implements CheckoutServices {
  final firestoreServices = FirestoreServices.instance;
  final authServices = Auth();

  @override
  Future<void> setPaymentMethod(PaymentMethod paymentMethod) async {
    final currentUser = authServices.currentUser;

    await firestoreServices.setData(
      path: ApiPath.addCard(currentUser!.uid, paymentMethod.id),
      data: paymentMethod.toMap(),
    );
  }

  @override
  Future<void> deletePaymentMethod(PaymentMethod paymentMethod) async {
    final currentUser = authServices.currentUser;

    await firestoreServices.deleteData(
      path: ApiPath.addCard(currentUser!.uid, paymentMethod.id),
    );
  }

  @override
  Future<List<PaymentMethod>> paymentMethods(
      [bool fetchPreferred = false]) async {
    final currentUser = authServices.currentUser;

    return await firestoreServices.getCollection(
      path: ApiPath.cards(currentUser!.uid),
      builder: (data, documentId) => PaymentMethod.fromMap(data),
      queryBuilder: fetchPreferred == true
          ? (query) => query.where('isPreferred', isEqualTo: true)
          : null,
    );
  }

  @override
  Future<List<DeliveryMethod>> deliveryMethods() async =>
      await firestoreServices.getCollection(
        path: ApiPath.deliveryMethods(),
        builder: (data, documentId) => DeliveryMethod.fromMap(data, documentId),
      );

  @override
  Future<List<ShippingAddress>> shippingAddresses(String userId) async =>
      await firestoreServices.getCollection(
        path: ApiPath.userShippingAddress(userId),
        builder: (data, documentId) =>
            ShippingAddress.fromMap(data, documentId),
      );

  @override
  Future<void> saveAddress(String userId, ShippingAddress address) async =>
      await firestoreServices.setData(
        path: ApiPath.newAddress(userId, address.id),
        data: address.toMap(),
      );
}
