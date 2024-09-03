import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/services/home_services.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServicesImpl();

  Future<void> getHomeContent() async {
    emit(HomeLoading());
    try {
      final newProducts = await homeServices.getNewProducts();
      final salesProducts = await homeServices.getSalesProducts();

      emit(HomeSuccess(
        salesProducts: salesProducts,
        newProducts: newProducts,
      ));
    } catch (e) {
      emit(HomeFailed(e.toString()));
    }
  }
}
