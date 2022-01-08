import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/di.dart';
import 'package:muaho/data/di.dart';
import 'package:muaho/domain/di.dart';
import 'package:muaho/generated/codegen_loader.g.dart';
import 'package:muaho/presentation/address/address_info/address_screen.dart';
import 'package:muaho/presentation/address/create_address/create_location_screen.dart';
import 'package:muaho/presentation/cart/cart_screen.dart';
import 'package:muaho/presentation/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/presentation/deeplink/deeplink_handle_bloc.dart';
import 'package:muaho/presentation/di.dart';
import 'package:muaho/presentation/home/history/history_order_detail/order_detail_screen.dart';
import 'package:muaho/presentation/home/history/models/order_detail_argument.dart';
import 'package:muaho/presentation/home/home_screen.dart';
import 'package:muaho/presentation/login/login_screen.dart';
import 'package:muaho/presentation/order/order_screen.dart';
import 'package:muaho/presentation/payment/payment_screen.dart';
import 'package:muaho/presentation/register/register_screen.dart';
import 'package:muaho/presentation/search/hot_search/ui/hot_search_screen.dart';
import 'package:muaho/presentation/search/search_shop/ui/search_shop.dart';
import 'package:muaho/presentation/sign_in/sign_in.dart';
import 'package:muaho/presentation/voucher_list/ui/voucher_list_screen.dart';

import 'presentation/chat-support/chat_support.dart';

final getIt = GetIt.instance;
int startTime = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = true;
  _initDi();
  await Firebase.initializeApp();
  await getIt<AppLocalization>().initializeApp();
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
      useOnlyLangCode: true,
      assetLoader: CodegenLoader(),
      child: BlocProvider<DeeplinkHandleBloc>(
        create: (context) => getIt(),
        child: MyApp(),
      ),
    ),
  );
}

void _initDi() {
  commonDiConfig(getIt);
  domainDiConfig(getIt);
  dataDiConfig(getIt);
  presentationDiConfig(getIt);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartUpdateBloc>(
      create: (ctx) => getIt(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        title: 'Mua Ho',
        initialRoute: '/',
        theme: MyTheme.lightTheme,
        onGenerateRoute: (settings) {
          if (settings.name == SearchShopScreen.routeName) {
            final args = settings.arguments as SearchShopArgument;
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
          AddressScreen.routeName: (context) => AddressScreen(),
          CreateAddressScreen.routeName: (context) => CreateAddressScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          VoucherListScreen.routeName: (context) => VoucherListScreen(),
        },
        // ),
      ),
    );
  }
}
