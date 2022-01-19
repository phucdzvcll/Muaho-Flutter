import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/cart/presentation/cart_screen.dart';
import 'package:muaho/features/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/features/chat-support/chat_support.dart';
import 'package:muaho/features/deeplink/deeplink_handle_bloc.dart';
import 'package:muaho/features/di.dart';
import 'package:muaho/features/home/presentation/history/models/order_detail_argument.dart';
import 'package:muaho/features/main/bloc/main_bloc.dart';
import 'package:muaho/features/main/main_sreen.dart';
import 'package:muaho/features/order/presentation/order_screen.dart';
import 'package:muaho/features/payment/presentation/payment_screen.dart';
import 'package:muaho/features/register/register_screen.dart';
import 'package:muaho/features/search/hot_search/ui/hot_search_screen.dart';
import 'package:muaho/features/search/search_shop/ui/search_shop.dart';
import 'package:muaho/generated/codegen_loader.g.dart';

import 'common/di.dart';
import 'features/address_info/presentation/address_screen.dart';
import 'features/create_address/presentation/create_location_screen.dart';
import 'features/home/presentation/history/history_order_detail/order_detail_screen.dart';
import 'features/login/presentation/login_screen.dart';
import 'features/voucher_list/presentaition/voucher_list_screen.dart';

int startTime = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = true;
  var getIt = GetIt.instance;
  _initDi(getIt);
  await Firebase.initializeApp();
  await getIt.get<AppLocalization>().initializeApp();

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

void _initDi(GetIt getIt) {
  commonDiConfig(getIt);
  featuresDiConfig(getIt);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartUpdateBloc>(
      create: (ctx) => inject(),
      child: BlocProvider<MainBloc>(
        create: (context) => inject()..add(InitThemeEvent()),
        child: BlocBuilder<MainBloc, MainState>(
          buildWhen: (pre, curr) => curr is ChangeThemeState,
          builder: (context, state) {
            return _buildMaterialApp(
                context,
                MainScreen.routeName,
                state is ChangeThemeState && state.isDark
                    ? MyTheme.darkTheme
                    : MyTheme.lightTheme);
          },
        ),
      ),
    );
  }

  MaterialApp _buildMaterialApp(
      BuildContext context, String initRoute, ThemeData themeData) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0x00FFFFFF),
        systemNavigationBarColor: themeData.unselectedWidgetColor,
        systemNavigationBarDividerColor: themeData.unselectedWidgetColor,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarIconBrightness:
            themeData.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
        statusBarIconBrightness: themeData.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: themeData.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Mua Ho',
      initialRoute: initRoute,
      theme: themeData,
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
        SearchScreen.routeName: (context) => SearchScreen(),
        CartScreen.routeName: (context) => CartScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
        PaymentScreen.routeName: (context) => PaymentScreen(),
        AddressScreen.routeName: (context) => AddressScreen(),
        CreateAddressScreen.routeName: (context) => CreateAddressScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        VoucherListScreen.routeName: (context) => VoucherListScreen(),
        MainScreen.routeName: (context) => MainScreen(),
      },
      // ),
    );
  }
}
