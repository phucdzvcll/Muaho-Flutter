import 'package:get_it/get_it.dart';

import 'bloc/main_bloc.dart';

void mainConfig(GetIt injector) {
  injector.registerFactory(
    () {
      return MainBloc(
        appEventBus: injector(),
        currentMode: injector(),
      );
    },
  );
}
