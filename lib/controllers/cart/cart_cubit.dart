import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/services/auth_services.dart';
import 'package:flutter_ecommerce/services/cart_services.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final authServices = AuthServicesImpl();
  final cartServices = CartServicesImpl();

  Future<void> getCartItems() async {
    emit(CartLoading());
    try {
      final currentUser = authServices.currentUser;
      final cartProducts = await cartServices.getCartProducts(currentUser!.uid);
      final totalAmount = cartProducts.fold<double>(
          0, (previousValue, element) => previousValue + element.price);
      emit(CartLoaded(cartProducts, totalAmount));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
