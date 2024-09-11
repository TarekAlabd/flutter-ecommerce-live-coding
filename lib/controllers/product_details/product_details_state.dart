part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final Product product;

  ProductDetailsLoaded(this.product);
}

final class ProductDetailsError extends ProductDetailsState {
  final String error;

  ProductDetailsError(this.error);
}

final class AddingToCart extends ProductDetailsState {}

final class AddedToCart extends ProductDetailsState {}

final class AddToCartError extends ProductDetailsState {
  final String error;

  AddToCartError(this.error);
}

final class SizeSelected extends ProductDetailsState {
  final String size;

  SizeSelected(this.size);
}
