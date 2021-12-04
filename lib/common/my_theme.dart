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
  static final primaryColor = Color(0xffDF5A00);
  static final primaryButtonColor = Color(0xffFA7921);
  static final activeButtonColor = Color(0x4dffffff);
  static final backgroundColor = Color(0xffF6EADF);
  static final borderLineColor = Color(0xfff2c09d);
  static final lessImportantTextColor = Color(0xff929292);
  static final spacingColor = Color(0xffcdc2b8);
  static final double radiusSize = 16;
  static final double paddingSize = 16;
  static final lightTheme = ThemeData(
    primaryColorLight: primaryButtonColor,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: backgroundColor,
        titleTextStyle: TextStyle(
          fontSize: 18,
          color: Color(0xff4E4E4E),
          fontStyle: FontStyle.normal,
        )),
    scaffoldBackgroundColor: backgroundColor,
    backgroundColor: backgroundColor,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    textTheme: TextTheme(
      headline1: GoogleFonts.mulish(
        fontSize: 24,
        color: Color(0xff4E4E4E),
        fontStyle: FontStyle.normal,
      ),
      headline2: GoogleFonts.mulish(
        fontSize: 18,
        color: Color(0xff4E4E4E),
        fontStyle: FontStyle.normal,
      ),
      headline3: GoogleFonts.mulish(
        fontSize: 16,
        color: Color(0xff4E4E4E),
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
      subtitle1: GoogleFonts.mulish(
        fontSize: 16,
        color: Color(0xff4E4E4E),
        fontStyle: FontStyle.normal,
      ),
      subtitle2: GoogleFonts.mulish(
        fontSize: 14,
        color: Color(0xff4E4E4E),
        fontStyle: FontStyle.normal,
      ),
      bodyText1: GoogleFonts.mulish(
        fontSize: 16,
        fontStyle: FontStyle.normal,
        color: Color(0xff4E4E4E),
      ),
      bodyText2: GoogleFonts.mulish(
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: Color(0xff4E4E4E),
      ),
      caption: GoogleFonts.mulish(
        fontSize: 12,
        fontStyle: FontStyle.normal,
        color: Color(0xff4E4E4E),
      ),
      button: GoogleFonts.mulish(
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: Color(0xffffffff),
      ),
    ),
  );

  static final ButtonStyle buttonStyleNormal = ElevatedButton.styleFrom(
    primary: primaryButtonColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
  static final ButtonStyle buttonStyleNormalLessImportant =
      ElevatedButton.styleFrom(
    primary: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      side: BorderSide(color: primaryButtonColor),
    ),
  );
  static final ButtonStyle buttonStyleDisable = ElevatedButton.styleFrom(
    primary: Color(0xffF2985A),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
  static final ButtonStyle buttonStyleDisableLessImportant =
      ElevatedButton.styleFrom(
    elevation: 0,
    primary: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      side: BorderSide(color: Color(0xff929292)),
    ),
  );
}
