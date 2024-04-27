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

final class DeletingCards extends CheckoutState {}

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
