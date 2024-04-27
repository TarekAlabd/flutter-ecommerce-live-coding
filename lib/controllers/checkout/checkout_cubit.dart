import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/payment_method.dart';
import 'package:flutter_ecommerce/services/checkout_services.dart';
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final checkoutServices = CheckoutServicesImpl();

  Future<void> addCard(PaymentMethod paymentMethod) async {
    emit(AddingCards());

    try {
      await checkoutServices.addPaymentMethod(paymentMethod);
      emit(CardsAdded());
    } catch (e) {
      emit(CardsAddingFailed(e.toString()));
    }
  }

  Future<void> deleteCard(PaymentMethod paymentMethod) async {
    emit(DeletingCards());

    try {
      await checkoutServices.deletePaymentMethod(paymentMethod);
      emit(CardsDeleted());
    } catch (e) {
      emit(CardsDeletingFailed(e.toString()));
    }
  }

  Future<void> fetchCards() async {
    emit(FetchingCards());

    try {
      final paymentMethods = await checkoutServices.paymentMethods();
      emit(CardsFetched(paymentMethods));
    } catch (e) {
      emit(CardsFetchingFailed(e.toString()));
    }
  }
}
