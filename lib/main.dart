import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/data/remote/order/order_service.dart';
import 'package:muaho/data/repository/order_repository.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/order/create_oreder_use_case.dart';
import 'package:muaho/generated/codegen_loader.g.dart';
import 'package:muaho/presentation/cart/cart_screen.dart';
import 'package:muaho/presentation/home/history/history_order_detail/order_detail_screen.dart';
import 'package:muaho/presentation/home/history/models/order_detail_argument.dart';
import 'package:muaho/presentation/home/home_screen.dart';
import 'package:muaho/presentation/order/order_screen.dart';
import 'package:muaho/presentation/payment/payment_screen.dart';
import 'package:muaho/presentation/search/hot_search/ui/hot_search_screen.dart';
import 'package:muaho/presentation/search/search_shop/ui/search_shop.dart';
import 'package:muaho/presentation/sign_in/sign_in.dart';

import 'presentation/chat-support/chat-support.dart';

//flutter pub run easy_localization:generate --source-dir ./assets/translations
//flutter pub run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart
//flutter pub run build_runner build --delete-conflicting-outputs
final getIt = GetIt.instance;
int startTime = 0;

Future<void> main() async {
  startTime = DateTime.now().millisecondsSinceEpoch;
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
  //store
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => FlutterSecureStorage());
  //jwt
  getIt.registerSingleton<UserStore>(UserStore(storage: getIt.get()));
  //Cart store
  getIt.registerSingleton<CartStore>(
      CartStore(shopId: -1, shopName: "", shopAddress: "", productStores: []));
  //token expired handler
  getIt.registerSingleton<TokenExpiredHandler>(
      TokenExpiredHandler(userStore: getIt.get()));
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
  //history
  getIt.registerSingleton<HistoryService>(HistoryService(createDioInstance()));
  getIt.registerSingleton<HistoryPageRepository>(HistoryRepositoryImpl());
  //oder
  getIt.registerSingleton<OrderService>(OrderService(createDioInstance()));
  getIt.registerSingleton<CreateOrderRepository>(OrderRepositoryImpl());

  //Factory
  getIt.registerFactory(() => GetListBannerUseCase());
  getIt.registerFactory(() => GetListProductCategoriesHomeUseCase());
  getIt.registerFactory(() => GetHotSearchUseCase());
  getIt.registerFactory(() => GetListShopBySearchUseCase());
  getIt.registerFactory(() => SignInUseCase());
  getIt.registerFactory(() => GetShopProductUseCase());
  getIt.registerFactory(
      () => GetOrderHistoryDeliveryUseCase(historyRepository: getIt.get()));
  getIt.registerFactory(() => GetOrderHistoryCompleteUseCase());
  getIt.registerFactory(() => GetOrderDetailUseCase());
  getIt.registerFactory(() => CreateOrderUseCase());
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
        if (settings.name == OrderDetail.routeName) {
          final args = settings.arguments as OrderDetailArgument;
          return MaterialPageRoute(builder: (context) {
            return OrderDetail(argument: args);
          });
        }
      },
      routes: {
        "/": (context) => SignIn(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
        CartScreen.routeName: (context) => CartScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
        PaymentScreen.routeName: (context) => PaymentScreen(),
      },
      // ),
    );
  }
}
