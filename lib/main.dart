import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/my_theme.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/data/remote/search/search_service.dart';
import 'package:muaho/data/remote/shop/shop_service.dart';
import 'package:muaho/data/remote/sign_in/sign_in_service.dart';
import 'package:muaho/data/repository/search_repository.dart';
import 'package:muaho/data/repository/shop_repository.dart';
import 'package:muaho/data/repository/sign_in_repository.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/repository/search_repository.dart';
import 'package:muaho/domain/use_case/search/get_list_hot_search_use_case.dart';
import 'package:muaho/domain/use_case/shop/get_shop_product_use_case.dart';
import 'package:muaho/domain/use_case/sign_in/get_jwt_token_use_case.dart';
import 'package:muaho/generated/codegen_loader.g.dart';
import 'package:muaho/presentation/home/home_screen.dart';
import 'package:muaho/presentation/search/hot_search/ui/hot_search_screen.dart';
import 'package:muaho/presentation/search/search_shop/ui/search_shop.dart';
import 'package:muaho/presentation/shop/order_screen.dart';
import 'package:muaho/presentation/sign_in/sign_in.dart';

//flutter pub run easy_localization:generate --source-dir ./assets/translations
//flutter pub run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart
//flutter pub run build_runner build --delete-conflicting-outputs
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  _initDi();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0x00FFFFFF),
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
  IdTokenResult? token;
  var auth = FirebaseAuth.instance;
  try {
    if (auth.currentUser != null) {
      await auth.signOut();
    }
    // await auth.signInWithEmailAndPassword(
    //     email: 'phuc1@gmail.com', password: '111111');
    await auth.signInAnonymously();
  } on FirebaseAuthException catch (e) {
    log("Login Error");
  }
  if (FirebaseAuth.instance.currentUser != null) {
    token = await FirebaseAuth.instance.currentUser!.getIdTokenResult(true);
    log(token.token!);
  } else {}

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('vi')],
        path: 'assets/translations',
        startLocale: Locale('vi'),
        fallbackLocale: Locale('vi'),
        assetLoader: CodegenLoader(),
        child: MyApp(
            firebaseToken: token == null ? "" : token.token.defaultEmpty())),
  );
}

void _initDi() {
  //Singleton
  // //homePage
  GetIt.instance
      .registerSingleton<HomeService>(HomeService(createDioInstance()));
  GetIt.instance.registerSingleton<HomePageRepository>(HomeRepositoryImpl());
  //searchPage
  GetIt.instance
      .registerSingleton<SearchService>(SearchService(createDioInstance()));
  GetIt.instance.registerSingleton<SearchRepository>(SearchRepositoryImpl());
  //signIn
  GetIt.instance
      .registerSingleton<SignInService>(SignInService(Dio(baseOptions)));
  GetIt.instance.registerSingleton<SignInRepository>(SignInRepositoryIplm());
  //shop
  GetIt.instance
      .registerSingleton<ShopService>(ShopService(createDioInstance()));
  GetIt.instance.registerSingleton<ShopRepository>(ShopRepositoryImpl());

  //Factory
  GetIt.instance.registerFactory(() => GetListBannerUseCase());
  GetIt.instance.registerFactory(() => GetListProductCategoriesHomeUseCase());
  GetIt.instance.registerFactory(() => GetHotSearchUseCase());
  GetIt.instance.registerFactory(() => GetListShopBySearchUseCase());
  GetIt.instance.registerFactory(() => GetJwtTokenUseCase());
  GetIt.instance.registerFactory(() => GetShopProductUseCase());
}

class MyApp extends StatelessWidget {
  final String firebaseToken;

  const MyApp({Key? key, required this.firebaseToken}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Mua Ho',
      initialRoute: '/',
      theme: MyTheme.lightTheme,
      onGenerateRoute: (settings) {
        if (settings.name == SearchShopScreen.routeName) {
          final args = settings.arguments as SearchArgument;
          return MaterialPageRoute(builder: (context) {
            return SearchShopScreen(args: args);
          });
        }
        if (settings.name == OrderScreen.routeName) {
          final args = settings.arguments as ShopArgument;
          return MaterialPageRoute(builder: (context) {
            return OrderScreen(shopArgument: args);
          });
        }
      },
      routes: {
        "/": (context) => SignIn(firebaseToken: firebaseToken),
        HomeScreen.routeName: (context) => HomeScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
      },
      // ),
    );
  }
}
