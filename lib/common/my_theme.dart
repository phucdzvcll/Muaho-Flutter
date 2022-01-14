import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  /*
    App Color:
    - Background: F2985A
    - Primary Color: DF5A00
    - Text Color:
      + FFFFFF
      + 4E4E4E
      + 7E7E7E
      + 929292
    - Other:
      + FA7921
      + F2985A
  */
  // static final primaryColorDark = Color(0xff322bb3);
  // static final primaryButtonColorDark = Color(0xff4a8cd5);
  // static final activeButtonColorDark = Color(0x4d9c4d4d);
  // static final backgroundColorDark = Color(0xffa17342);
  // static final borderLineColorDark = Color(0xff5db33d);
  // static final lessImportantTextColorDark = Color(0xffee9999);
  // static final backgroundCardColorDark = Color(0xfff3f3f3);
  // static final spacingColorDark = Color(0xff8840bb);
  // static final double radiusSizeDark = 16;
  // static final double paddingSizeDark = 16;

  static final primaryColorLight = Color(0xfffa7921);
  static final primaryLight = Color(0xffDF5A00);
  static final primaryBackgroundLight = Color(0xffffffff);
  static final focusColorLight = Color(0xff929292);
  static final cardBackgroundLight = Color(0xfffae4d0);
  static final scaffoldBackgroundLight = Colors.white;
  static final unselectedWidgetColorLight = Colors.black;
  static final textColorLight = Color(0xff4E4E4E);

  static final ThemeData lightTheme = ThemeData(
    primaryColorLight: primaryColorLight,
    primaryColor: primaryLight,
    backgroundColor: primaryBackgroundLight,
    scaffoldBackgroundColor: scaffoldBackgroundLight,
    primaryColorBrightness: Brightness.light,
    brightness: Brightness.light,
    focusColor: focusColorLight,
    disabledColor: focusColorLight,
    cardColor: cardBackgroundLight,
    unselectedWidgetColor: unselectedWidgetColorLight,
    dialogBackgroundColor: cardBackgroundLight,
    dialogTheme: DialogTheme(
      contentTextStyle: GoogleFonts.mulish(
        fontSize: 16,
        color: textColorLight,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
      titleTextStyle: GoogleFonts.mulish(
        fontSize: 18,
        color: textColorLight,
        fontStyle: FontStyle.normal,
      ),
      backgroundColor: cardBackgroundLight,
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: GoogleFonts.mulish(
        fontSize: 16,
        color: scaffoldBackgroundLight,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      labelColor: scaffoldBackgroundLight,
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: GoogleFonts.mulish(
        fontSize: 16,
        color: textColorLight,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      indicator: BoxDecoration(
        color: primaryColorLight,
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: primaryColorLight,
      selectedItemColor: Color(0x4dffffff),
    ),
    appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: unselectedWidgetColorLight),
        backgroundColor: primaryBackgroundLight,
        titleTextStyle: TextStyle(
          fontSize: 18,
          color: textColorLight,
          fontStyle: FontStyle.normal,
        )),
    textTheme: TextTheme(
      headline1: GoogleFonts.mulish(
        fontSize: 24,
        color: textColorLight,
        fontStyle: FontStyle.normal,
      ),
      headline2: GoogleFonts.mulish(
        fontSize: 18,
        color: textColorLight,
        fontStyle: FontStyle.normal,
      ),
      headline3: GoogleFonts.mulish(
        fontSize: 16,
        color: textColorLight,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
      subtitle1: GoogleFonts.mulish(
        fontSize: 16,
        color: textColorLight,
        fontStyle: FontStyle.normal,
      ),
      subtitle2: GoogleFonts.mulish(
        fontSize: 14,
        color: textColorLight,
        fontStyle: FontStyle.normal,
      ),
      bodyText1: GoogleFonts.mulish(
        fontSize: 16,
        fontStyle: FontStyle.normal,
        color: textColorLight,
      ),
      bodyText2: GoogleFonts.mulish(
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: textColorLight,
      ),
      caption: GoogleFonts.mulish(
        fontSize: 12,
        fontStyle: FontStyle.normal,
        color: textColorLight,
      ),
      button: GoogleFonts.mulish(
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: Color(0xffffffff),
      ),
    ),
  );

  static final primaryDark = Color(0xff0b533a);
  static final primaryColorDark = Color(0xff4b8c8a);
  static final cardBackgroundDark = Color(0xff0f1f24);
  static final focusColorDark = Color(0xffc4c4c4);
  static final primaryBackgroundDark = Color(0xff000000);
  static final scaffoldBackgroundDark = Colors.black;
  static final unselectedWidgetColorDark = Colors.white;
  static final textColorDark = Color(0xffF5EDED);

  static final ThemeData darkTheme = ThemeData(
    primaryColorLight: primaryColorDark,
    primaryColor: primaryDark,
    backgroundColor: primaryBackgroundDark,
    scaffoldBackgroundColor: scaffoldBackgroundDark,
    primaryColorBrightness: Brightness.dark,
    brightness: Brightness.dark,
    focusColor: focusColorDark,
    disabledColor: focusColorDark,
    cardColor: cardBackgroundDark,
    unselectedWidgetColor: unselectedWidgetColorDark,
    dialogBackgroundColor: cardBackgroundDark,
    dialogTheme: DialogTheme(
      contentTextStyle: GoogleFonts.mulish(
        fontSize: 16,
        color: textColorDark,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
      titleTextStyle: GoogleFonts.mulish(
        fontSize: 18,
        color: textColorDark,
        fontStyle: FontStyle.normal,
      ),
      backgroundColor: cardBackgroundDark,
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: GoogleFonts.mulish(
        fontSize: 16,
        color: scaffoldBackgroundDark,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: GoogleFonts.mulish(
        fontSize: 16,
        color: textColorDark,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      indicator: BoxDecoration(
        color: primaryColorDark,
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: primaryColorDark,
      selectedItemColor: Color(0x4dffffff),
    ),
    appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: unselectedWidgetColorDark),
        backgroundColor: primaryBackgroundDark,
        titleTextStyle: TextStyle(
          fontSize: 18,
          color: textColorDark,
          fontStyle: FontStyle.normal,
        )),
    textTheme: TextTheme(
      headline1: GoogleFonts.mulish(
        fontSize: 24,
        color: textColorDark,
        fontStyle: FontStyle.normal,
      ),
      headline2: GoogleFonts.mulish(
        fontSize: 18,
        color: textColorDark,
        fontStyle: FontStyle.normal,
      ),
      headline3: GoogleFonts.mulish(
        fontSize: 16,
        color: textColorDark,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
      subtitle1: GoogleFonts.mulish(
        fontSize: 16,
        color: textColorDark,
        fontStyle: FontStyle.normal,
      ),
      subtitle2: GoogleFonts.mulish(
        fontSize: 14,
        color: textColorDark,
        fontStyle: FontStyle.normal,
      ),
      bodyText1: GoogleFonts.mulish(
        fontSize: 16,
        fontStyle: FontStyle.normal,
        color: textColorDark,
      ),
      bodyText2: GoogleFonts.mulish(
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: textColorDark,
      ),
      caption: GoogleFonts.mulish(
        fontSize: 12,
        fontStyle: FontStyle.normal,
        color: textColorDark,
      ),
      button: GoogleFonts.mulish(
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: cardBackgroundDark,
      ),
    ),
  );
}
