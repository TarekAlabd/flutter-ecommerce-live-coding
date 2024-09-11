part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartProducts;
  final double totalAmount;

  CartLoaded(this.cartProducts, this.totalAmount);
}

final class CartError extends CartState {
  final String message;

  CartError(this.message);
}
