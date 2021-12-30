import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/common/geolocator/geolocator.dart';

import 'common.dart';

void commonDiConfig(GetIt injector) {
  injector.registerLazySingleton<AppLocalization>(() {
    return AppLocalization();
  });

  injector.registerLazySingleton<AppGeoLocator>(() => AppGeoLocator());

  //store
  injector.registerLazySingleton<FlutterSecureStorage>(
      () => FlutterSecureStorage());

  injector.registerLazySingleton<CartStore>(() => CartStore());

  //jwt
  injector
      .registerLazySingleton<UserStore>(() => UserStore(storage: injector()));

  injector.registerLazySingleton<DioFactory>(() => DioFactory(
        tokenExpiredHandler: injector(),
        userStore: injector(),
      ));

  //jwt
  injector.registerLazySingleton<Dio>(
    () => injector.get<DioFactory>().create(DioInstanceType.DioTokenHandler),
    instanceName: DioInstanceType.DioTokenHandler.name,
  );

  injector.registerLazySingleton<Dio>(
    () => injector.get<DioFactory>().create(DioInstanceType.Dio),
    instanceName: DioInstanceType.Dio.name,
  );

  //token expired handler
  injector.registerLazySingleton<TokenExpiredHandler>(
      () => TokenExpiredHandler(userStore: injector()));
}
