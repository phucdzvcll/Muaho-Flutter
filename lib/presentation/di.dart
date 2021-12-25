import 'package:get_it/get_it.dart';

import 'cart/bloc/cart_bloc.dart';
import 'chat-support/bloc/chat_bloc.dart';
import 'home/history/complete/bloc/order_history_complete_bloc.dart';
import 'home/history/delivering/bloc/order_history_delivering_bloc.dart';
import 'home/history/history_order_detail/bloc/order_detail_bloc.dart';
import 'home/home_page/bloc/home_page_bloc.dart';
import 'order/bloc/order_bloc.dart';
import 'payment/bloc/payment_bloc.dart';
import 'search/hot_search/bloc/hot_search_bloc.dart';
import 'search/search_shop/bloc/search_shop_bloc.dart';
import 'sign_in/bloc/sign_bloc_bloc.dart';

void presentationDiConfig(GetIt injector) {
  injector.registerFactory(() => SignBloc(signInUseCase: injector()));

  injector.registerFactory(
      () => SearchShopBloc(getListShopBySearchUseCase: injector()));

  injector
      .registerFactory(() => HotSearchBloc(getHotSearchUseCase: injector()));

  injector.registerFactory(
      () => PaymentBloc(cartStore: injector(), createOrderUseCase: injector()));

  injector.registerFactory(() =>
      OrderBloc(cartStore: injector(), getShopProductUseCase: injector()));

  injector.registerFactory(() => HomePageBloc(
        bannerUseCase: injector(),
        useCaseProductCategories: injector(),
      ));

  injector.registerFactory(
      () => OrderDetailBloc(getOrderDetailUseCase: injector()));

  injector.registerFactory(() =>
      OrderHistoryDeliveringBloc(getOrderHistoryDeliveryUseCase: injector()));

  injector.registerFactory(() =>
      OrderHistoryCompleteBloc(getOrderHistoryCompleteUseCase: injector()));

  injector.registerFactory(() => ChatBloc(userStore: injector()));

  injector.registerFactory(() => CartBloc(cartStore: injector()));
}
