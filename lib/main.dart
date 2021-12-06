import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
import 'package:muaho/domain/use_case/history/get_order_history_delivery_use_case.dart';
import 'package:muaho/domain/use_case/search/get_list_hot_search_use_case.dart';
import 'package:muaho/domain/use_case/shop/get_shop_product_use_case.dart';
import 'package:muaho/domain/use_case/sign_in/get_jwt_token_use_case.dart';
import 'package:muaho/generated/codegen_loader.g.dart';
import 'package:muaho/presentation/cart/cart_screen.dart';
import 'package:muaho/presentation/home/home_screen.dart';
import 'package:muaho/presentation/order/order_screen.dart';
import 'package:muaho/presentation/search/hot_search/ui/hot_search_screen.dart';
import 'package:muaho/presentation/search/search_shop/ui/search_shop.dart';
import 'package:muaho/presentation/sign_in/sign_in.dart';

//flutter pub run easy_localization:generate --source-dir ./assets/translations
//flutter pub run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart
//flutter pub run build_runner build --delete-conflicting-outputs
final storage = new FlutterSecureStorage();
final getIt = GetIt.instance;

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

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('vi')],
        path: 'assets/translations',
        startLocale: Locale('vi'),
        fallbackLocale: Locale('vi'),
        assetLoader: CodegenLoader(),
        child: MyApp()),
  );
}

void _initDi() {
  //Singleton

  //token expired handler
  getIt.registerSingleton<TokenExpiredHandler>(TokenExpiredHandler());
  //homePage
  getIt.registerSingleton<HomeService>(HomeService(createDioInstance()));
  getIt.registerSingleton<HomePageRepository>(HomeRepositoryImpl());
  //searchPage
  getIt.registerSingleton<SearchService>(SearchService(createDioInstance()));
  getIt.registerSingleton<SearchRepository>(SearchRepositoryImpl());
  //signIn
  getIt.registerSingleton<SignInService>(SignInService(Dio(baseOptions)));
  getIt.registerSingleton<SignInRepository>(SignInRepositoryImpl());
  //shop
  getIt.registerSingleton<ShopService>(ShopService(createDioInstance()));
  getIt.registerSingleton<ShopRepository>(ShopRepositoryImpl());
  //jwt
  getIt.registerSingleton<TokenStore>(TokenStore(""));
  //history
  getIt.registerSingleton<HistoryService>(HistoryService(createDioInstance()));
  getIt.registerSingleton<HistoryPageRepository>(HistoryRepositoryImpl());

  //Factory
  getIt.registerFactory(() => GetListBannerUseCase());
  getIt.registerFactory(() => GetListProductCategoriesHomeUseCase());
  getIt.registerFactory(() => GetHotSearchUseCase());
  getIt.registerFactory(() => GetListShopBySearchUseCase());
  getIt.registerFactory(() => GetJwtTokenUseCase());
  getIt.registerFactory(() => GetShopProductUseCase());
  getIt.registerFactory(() => GetOrderHistoryDeliveryUseCase());
  getIt.registerFactory(() => GetOrderHistoryCompleteUseCase());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        "/": (context) => SignIn(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
        CartScreen.routeName: (context) => CartScreen(),
      },
      // ),
    );
  }
}
