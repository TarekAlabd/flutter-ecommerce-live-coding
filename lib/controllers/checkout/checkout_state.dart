part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class AddingCards extends CheckoutState {}

final class CardsAdded extends CheckoutState {}

final class CardsAddingFailed extends CheckoutState {
  final String error;

  CardsAddingFailed(this.error);
}

final class DeletingCards extends CheckoutState {
  final String paymentId;

  DeletingCards(this.paymentId);
}

final class CardsDeleted extends CheckoutState {}

final class CardsDeletingFailed extends CheckoutState {
  final String error;

  CardsDeletingFailed(this.error);
}

final class FetchingCards extends CheckoutState {}

final class CardsFetched extends CheckoutState {
  final List<PaymentMethod> paymentMethods;

  CardsFetched(this.paymentMethods);
}

final class CardsFetchingFailed extends CheckoutState {
  final String error;

  CardsFetchingFailed(this.error);
}

final class MakingPreferred extends CheckoutState {}

final class PreferredMade extends CheckoutState {}

final class PreferredMakingFailed extends CheckoutState {
  final String error;

  PreferredMakingFailed(this.error);
}

final class MakingPayment extends CheckoutState {}

final class PaymentMade extends CheckoutState {}

final class PaymentMakingFailed extends CheckoutState {
  final String error;

  PaymentMakingFailed(this.error);
}
