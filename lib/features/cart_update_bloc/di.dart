import 'package:get_it/get_it.dart';

import 'cart_update_bloc.dart';

void cartUpdateConfig(GetIt injector) {
  injector.registerFactory<CartUpdateBloc>(() => CartUpdateBloc(
        cartStore: injector(),
        appEventBus: injector(),
      ));
}
