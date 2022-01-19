import 'package:get_it/get_it.dart';

import 'bloc/chat_bloc.dart';

void chatConfig(GetIt injector) {
  injector.registerFactory(() => ChatBloc(userStore: injector()));
}
