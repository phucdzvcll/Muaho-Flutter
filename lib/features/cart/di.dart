import 'package:get_it/get_it.dart';
import 'package:muaho/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:muaho/features/cart_update_bloc/cart_update_bloc.dart';

void cartConfig(GetIt injector) {
  injector.registerFactoryParam<CartBloc, CartUpdateBloc, void>(
      (cartUpdateBloc, _) => CartBloc(
            cartUpdateBloc: cartUpdateBloc,
          ));
}
