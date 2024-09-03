import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/payment_method.dart';
import 'package:flutter_ecommerce/services/checkout_services.dart';
import 'package:flutter_ecommerce/services/stripe_services.dart';
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final checkoutServices = CheckoutServicesImpl();
  final stripeServices = StripeServices.instance;

  Future<void> makePayment(double amount) async {
    emit(MakingPayment());

    try {
      await stripeServices.makePayment(amount, 'usd');
      emit(PaymentMade());
    } catch (e) {
      debugPrint(e.toString());
      emit(PaymentMakingFailed(e.toString()));
    }
  }

  Future<void> addCard(PaymentMethod paymentMethod) async {
    emit(AddingCards());

    try {
      await checkoutServices.setPaymentMethod(paymentMethod);
      emit(CardsAdded());
    } catch (e) {
      emit(CardsAddingFailed(e.toString()));
    }
  }

  Future<void> deleteCard(PaymentMethod paymentMethod) async {
    emit(DeletingCards(paymentMethod.id));

    try {
      await checkoutServices.deletePaymentMethod(paymentMethod);
      emit(CardsDeleted());
      await fetchCards();
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

  Future<void> makePreferred(PaymentMethod paymentMethod) async {
    emit(FetchingCards());

    try {
      final preferredPaymentMethods =
          await checkoutServices.paymentMethods(true);
      for (var method in preferredPaymentMethods) {
        final newPaymentMethod = method.copyWith(isPreferred: false);
        await checkoutServices.setPaymentMethod(newPaymentMethod);
      }
      final newPreferredMethod = paymentMethod.copyWith(isPreferred: true);
      await checkoutServices.setPaymentMethod(newPreferredMethod);
      emit(PreferredMade());
    } catch (e) {
      emit(PreferredMakingFailed(e.toString()));
    }
  }
}
