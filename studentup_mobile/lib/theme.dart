import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentupTheme {
  static final MaterialColor colorSwatch =
      MaterialColor(0xFF6AE59B, <int, Color>{
    50: Color(0xFFF0FCF5),
    100: Color(0xFFd2f7e1),
    200: Color(0xFFb5f2cd),
    300: Color(0xFF97edb9),
    400: Color(0xFF79e8a5),
    500: Color(0xFF6ae59b), //<= main color
    600: Color(0xFF5fce8c),
    700: Color(0xFF4aa06d),
    800: Color(0xFF35734e),
    900: Color(0xFF20452e),
  });
  static final MaterialAccentColor accentColorSwatch =
      MaterialAccentColor(0xFF6AE59B, <int, Color>{
    50: Color(0xFFF0FCF5),
    100: Color(0xFFd2f7e1),
    200: Color(0xFFb5f2cd),
    400: Color(0xFF79e8a5),
    700: Color(0xFF4aa06d),
  });
  static final ThemeData theme = ThemeData(
    primarySwatch: colorSwatch,
  );

  // brightness: Brightness.light,
  // primaryColor: mainColor,
  // primaryColorBrightness: Brightness.light,
  // primaryColorLight: mainColor,
  // primaryColorDark: mainColor,
  // accentColor: accentColorSwatch.shade400,
  // accentColorBrightness: Brightness.light,
  // dividerColor: dividerColor,
  // splashColor: mainColor,
  // selectedRowColor: mainColor,
  // buttonColor: mainColor,
}
