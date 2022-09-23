import 'package:e_shop/domain/utils/constants.dart';
import 'package:flutter/material.dart';

//const String appColor = "9FE30B"/*"00E676"*//*"ff7803"*/;
const String appFont = "Manrope";
const String appColor = "";

const bool isDarkForAccent = true;

const Color colorDark = Color(0xFF121212);
const Color colorLight = Color(0xFFFFFFFF);
const Color colorAppLight = Color(0xFF9fe30b);
const Color colorAppDark = Color(0xFFB2EE32);

Color getBgColor(context) => Theme.of(context).brightness == Brightness.light ? colorLight: colorDark;

const textStyleBtnLight = TextStyle(
  fontSize: 16,
  color: Colors.white
);

final textStyleBtnDark = TextStyle(
  fontSize: 16,
  color: Colors.green.shade700
);

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: colorLight,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  useMaterial3: isIosApplication ?
  false : true,
  textTheme: const TextTheme(
    button: textStyleBtnLight,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
  fontFamily: appFont,
  colorScheme: const ColorScheme.light().copyWith(secondary: Colors.white),
);

ThemeData themeDark = ThemeData(
  scaffoldBackgroundColor: colorDark,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  useMaterial3: isIosApplication ?
  false : true,
  //floatingActionButtonTheme: fabTheme,
  textTheme: TextTheme(
    button: textStyleBtnDark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black54,
  ),
  brightness: Brightness.dark,
  fontFamily: appFont,
  colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.black),
);

ThemeMode getThemeMode(String mode){
  switch(mode){
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

