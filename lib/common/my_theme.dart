import 'package:flutter/material.dart';

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
  static final backgroundColor = Color(0xffF6EADF);
  static final borderLineColor = Color(0xfff2c09d);
  static final lessImportantTextColor = Color(0xff929292);
  static final double radiusSize = 16;
  static final double paddingSize = 16;
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: 'OldStandardTT',
    brightness: Brightness.light,
    primaryColor: primaryColor,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24,
        color: Color(0xff4E4E4E),
        fontStyle: FontStyle.normal,
      ),
      subtitle1: TextStyle(
        fontSize: 16,
        color: Color(0xff4E4E4E),
        fontStyle: FontStyle.normal,
      ),
      subtitle2: TextStyle(
        fontSize: 16,
        color: Color(0xff4E4E4E),
        fontStyle: FontStyle.normal,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.normal,
        color: Color(0xff4E4E4E),
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: Color(0xff4E4E4E),
      ),
      caption: TextStyle(
        fontSize: 12,
        fontStyle: FontStyle.normal,
        color: Color(0xff4E4E4E),
      ),
      button: TextStyle(
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: Color(0xffffffff),
      ),
    ),
  );

  static final ButtonStyle buttonStyleNormal = ElevatedButton.styleFrom(
    primary: primaryButtonColor,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
  static final ButtonStyle buttonStyleNormalLessImportant =
      ElevatedButton.styleFrom(
    primary: backgroundColor,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      side: BorderSide(color: primaryButtonColor),
    ),
  );
  static final ButtonStyle buttonStyleDisable = ElevatedButton.styleFrom(
    primary: Color(0xffF2985A),
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
  static final ButtonStyle buttonStyleDisableLessImportant =
      ElevatedButton.styleFrom(
    primary: backgroundColor,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      side: BorderSide(color: Color(0xff929292)),
    ),
  );
}