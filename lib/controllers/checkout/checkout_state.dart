part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final List<DeliveryMethod> deliveryMethods;
  final ShippingAddress? shippingAddress;

  CheckoutLoaded({
    required this.deliveryMethods,
    this.shippingAddress,
  });
}

final class CheckoutLoadingFailed extends CheckoutState {
  final String error;

  CheckoutLoadingFailed(this.error);
}

final class FetchingAddresses extends CheckoutState {}

final class AddressesFetched extends CheckoutState {
  final List<ShippingAddress> shippingAddresses;

  AddressesFetched(this.shippingAddresses);
}

final class AddressesFetchingFailed extends CheckoutState {
  final String error;

  AddressesFetchingFailed(this.error);
}

final class AddingAddress extends CheckoutState {}

final class AddressAdded extends CheckoutState {}

final class AddressAddingFailed extends CheckoutState {
  final String error;

  AddressAddingFailed(this.error);
}

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
