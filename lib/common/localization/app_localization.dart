import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class AppLocalization {
  Future initializeApp() async {
    await EasyLocalization.ensureInitialized();
  }

  Locale getCurrentLocale(BuildContext context) {
    return context.locale;
  }

  List<Locale> getSupportedLocales(BuildContext context) {
    return context.supportedLocales;
  }

  Future clearSaveLocale(BuildContext context) async {
    return context.deleteSaveLocale();
  }

  Future setLocale(BuildContext context, Locale locale) async {
    return context.setLocale(locale);
  }

  String translate(
    String key, {
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) {
    return key.tr(
      args: args,
      gender: gender,
      namedArgs: namedArgs,
    );
  }
}

extension Localization on String {
  String translate({
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) {
    return GetIt.instance.get<AppLocalization>().translate(
          this,
          args: args,
          gender: gender,
          namedArgs: namedArgs,
        );
  }
}
