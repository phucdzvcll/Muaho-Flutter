import 'package:app_links/app_links.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/presentation/address/address_info/bloc/address_bloc.dart';
import 'package:muaho/presentation/address/create_address/bloc/create_address_bloc.dart';
import 'package:muaho/presentation/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/presentation/deeplink/deeplink_handle_bloc.dart';
import 'package:muaho/presentation/home/setting_page/bloc/setting_bloc.dart';
import 'package:muaho/presentation/login/bloc/login_bloc.dart';
import 'package:muaho/presentation/register/bloc/register_bloc.dart';
import 'package:muaho/presentation/voucher_list/bloc/voucher_list_bloc.dart';

import 'cart/bloc/cart_bloc.dart';
import 'chat-support/bloc/chat_bloc.dart';
import 'home/history/complete/bloc/order_history_complete_bloc.dart';
import 'home/history/delivering/bloc/order_history_delivering_bloc.dart';
import 'home/history/history_order_detail/bloc/order_detail_bloc.dart';
import 'home/home_page/bloc/home_page_bloc.dart';
import 'main/bloc/main_bloc.dart';
import 'order/bloc/order_bloc.dart';
import 'payment/bloc/payment_bloc.dart';
import 'search/hot_search/bloc/hot_search_bloc.dart';
import 'search/search_shop/bloc/search_shop_bloc.dart';
import 'sign_in/bloc/sign_bloc_bloc.dart';

void presentationDiConfig(GetIt injector) {
  injector.registerFactory(
    () => SignBloc(
      signInUseCase: injector(),
    ),
  );

  injector.registerFactory(
      () => SearchShopBloc(getListShopBySearchUseCase: injector()));

  injector
      .registerFactory(() => HotSearchBloc(getHotSearchUseCase: injector()));

  injector.registerFactoryParam<PaymentBloc, CartUpdateBloc, void>(
    (cartUpdateBloc, _) => PaymentBloc(
      cartUpdateBloc: cartUpdateBloc,
      createOrderUseCase: injector(),
      appEventBus: injector(),
    ),
  );

  injector.registerFactoryParam<OrderBloc, CartUpdateBloc, void>(
      (cartUpdateBloc, _) => OrderBloc(
          getShopProductUseCase: injector(), cartUpdateBloc: cartUpdateBloc));

  injector.registerFactory(
    () => HomePageBloc(
      bannerUseCase: injector(),
      useCaseProductCategories: injector(),
      appEventBus: injector(),
      userStore: injector(),
      eventBus: injector(),
    ),
  );

  injector.registerFactory<CartUpdateBloc>(() => CartUpdateBloc(
        cartStore: injector(),
      ));

  injector.registerFactory<CreateAddressBloc>(() => CreateAddressBloc(
        appGeoLocator: injector(),
        createAddressUseCase: injector(),
      ));

  injector.registerFactory(
      () => OrderDetailBloc(getOrderDetailUseCase: injector()));

  injector.registerFactory(
    () => OrderHistoryDeliveringBloc(
        getOrderHistoryDeliveryUseCase: injector(), appEventBus: injector()),
  );

  injector.registerFactory(() =>
      OrderHistoryCompleteBloc(getOrderHistoryCompleteUseCase: injector()));

  injector.registerFactory(() => ChatBloc(userStore: injector()));

  injector.registerFactory(() => AddressBloc(
        getListAddressInfoUseCase: injector(),
      ));

  injector.registerFactoryParam<CartBloc, CartUpdateBloc, void>(
      (cartUpdateBloc, _) => CartBloc(
            cartUpdateBloc: cartUpdateBloc,
          ));

  injector.registerLazySingleton(
    () => AppLinks(onAppLink: (Uri uri, String stringUri) {}),
  );

  injector.registerLazySingleton(
      () => DeeplinkHandleBloc(appLinks: injector())..add(InitDeeplinkEvent()));

  injector.registerFactory(
    () => LoginBloc(
      loginEmailUseCase: injector(),
      appEventBus: injector(),
    ),
  );
  injector.registerFactory(
    () => RegisterBloc(
      registerEmailUseCase: injector(),
      appEventBus: injector(),
    ),
  );

  injector.registerFactory(
    () => SettingBloc(
      userStore: injector(),
      appEventBus: injector(),
      firebaseAuth: injector(),
    ),
  );
  injector.registerFactory(
    () => VoucherListBloc(
      getVoucherListUseCase: injector(),
    ),
  );

  injector.registerFactory(
    () {
      return MainBloc(
        appEventBus: injector(),
        currentMode: injector(),
      );
    },
  );
}
