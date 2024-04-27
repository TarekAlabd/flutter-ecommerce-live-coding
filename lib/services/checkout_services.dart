import 'package:flutter_ecommerce/models/payment_method.dart';
import 'package:flutter_ecommerce/services/auth.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';
import 'package:flutter_ecommerce/utilities/api_path.dart';

abstract class CheckoutServices {
  Future<void> addPaymentMethod(PaymentMethod paymentMethod);
  Future<void> deletePaymentMethod(PaymentMethod paymentMethod);
  Future<List<PaymentMethod>> paymentMethods();
}

class CheckoutServicesImpl implements CheckoutServices {
  final firestoreServices = FirestoreServices.instance;
  final authServices = Auth();

  @override
  Future<void> addPaymentMethod(PaymentMethod paymentMethod) async {
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
  Future<List<PaymentMethod>> paymentMethods() async {
    final currentUser = authServices.currentUser;

    return await firestoreServices.getCollection(
      path: ApiPath.cards(currentUser!.uid),
      builder: (data, documentId) => PaymentMethod.fromMap(data),
    );
  }
}
