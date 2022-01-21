import 'package:app_links/app_links.dart';
import 'package:get_it/get_it.dart';

import 'deeplink_handle_bloc.dart';

void deepLinkConfig(GetIt injector) {
  injector.registerLazySingleton(
    () => AppLinks(onAppLink: (Uri uri, String stringUri) {}),
  );

  injector.registerLazySingleton(
      () => DeeplinkHandleBloc(appLinks: injector())..add(InitDeeplinkEvent()));
}
