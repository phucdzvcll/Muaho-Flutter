import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/common/my_theme.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/data/remote/search/search_service.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/repository/search_page_repository.dart';
import 'package:muaho/domain/use_case/search/get_list_hot_search_use_case.dart';
import 'package:muaho/presentation/home/home_page/product_catrgory/product_category_bloc.dart';
import 'package:muaho/presentation/home/home_page/slide_banner/slide_banner_bloc.dart';
import 'package:muaho/presentation/home/home_screen.dart';
import 'package:muaho/presentation/search/search_screen.dart';

import 'common/my_theme.dart';
import 'data/repository/search_repository.dart';
import 'generated/codegen_loader.g.dart';

//flutter pub run easy_localization:generate --source-dir ./assets/translations
//flutter pub run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart
//flutter pub run build_runner build --delete-conflicting-outputs
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  //data
  //singleton
  final BaseOptions baseOptions = BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
    responseType: ResponseType.json,
  );
  final dio = Dio(baseOptions); // Provide a dio instance

  //Singleton
  //homePage
  GetIt.instance.registerSingleton<HomeService>(HomeService(dio));
  GetIt.instance.registerSingleton<HomePageRepository>(HomeRepositoryImpl());
  //searchPage
  GetIt.instance.registerSingleton<SearchService>(SearchService(dio));
  GetIt.instance
      .registerSingleton<SearchPageRepository>(SearchRepositoryImpl());
  //Factory
  GetIt.instance.registerFactory(() => GetListBannerUseCase());
  GetIt.instance.registerFactory(() => GetListProductCategoriesHomeUseCase());
  GetIt.instance.registerFactory(() => GetHotSearchUseCase());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SlideBannerBloc>(
            create: (context) =>
                SlideBannerBloc()..add(RequestListBannerEvent())),
        BlocProvider<ProductCategoryBloc>(
            create: (context) =>
                ProductCategoryBloc()..add(RequestProductCategoryEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        title: 'Flutter Demo',
        initialRoute: '/',
        theme: MyTheme.lightTheme,
        routes: {
          "/": (context) => HomeScreen(),
          "/search": (context) => SearchScreen(),
        },
      ),
    );
  }
}
