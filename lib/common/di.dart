import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/common/geolocator/geolocator.dart';
import 'package:muaho/common/model/mode_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';

Future<void> commonDiConfig(GetIt injector) async {
  injector.registerLazySingleton(() => FirebaseAuth.instance);

  injector.registerLazySingleton<AppLocalization>(() {
    return AppLocalization();
  });

  injector.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

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

  injector.registerLazySingleton(
    () => AppEventBus(),
  );

  injector.registerLazySingleton<CurrentMode>(
      () => CurrentMode(storage: injector()));
}
