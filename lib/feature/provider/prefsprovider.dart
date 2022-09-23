import 'dart:ui';
import 'package:e_shop/domain/model/preferences.dart';
import 'package:e_shop/domain/utils/constants.dart';
import 'package:e_shop/domain/utils/localization.dart';
import 'package:e_shop/domain/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceProvider extends ChangeNotifier {
  SharedPreferences? sp;

  String? currentTheme;
  int? currentColorIndex;

  Locale? locale;
  bool? isFirst;
  bool? is24HourFormat;

  PreferenceProvider() {
    _loadFromPrefs();
  }

  _initPrefs() async {
    sp ??= await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    if (sp!.getString(keyThemeMode) == null) await sp!.setString(keyThemeMode, "system");
    if (sp!.getInt(keyColorIndex) == null) await sp!.setInt(keyColorIndex, 0);
    if (sp!.getBool(keyIsFirst) == null) await sp!.setBool(keyIsFirst, true);
    if (sp!.getString(keyLanguage) == null) {
      switch (window.locale.languageCode) {
        case 'en':
        case 'be':
        case 'ru':
          locale = Locale(window.locale.languageCode, '');
          break;
        default:
          locale = const Locale('en', '');
      }
    } else {
      locale = Locale(sp!.getString(keyLanguage)!, '');
    }
    isFirst = sp!.getBool(keyIsFirst);
    is24HourFormat = sp!.getBool(key24Hour);
    currentTheme = sp!.getString(keyThemeMode);
    currentColorIndex = sp!.getInt(keyColorIndex) ?? 0;
    notifyListeners();
  }

  savePreference(String key, value) async {
    await _initPrefs();
    switch (key) {
      case keyThemeMode:
        sp!.setString(key, value);
        currentTheme = sp!.getString(keyThemeMode);
        break;
      case keyColorIndex:
        sp!.setInt(key, value);
        currentColorIndex = sp!.getInt(keyColorIndex);
        break;
      case keyThemeColor:
        sp!.setString(key, value);
        break;
      case keyIsDarkColor:
        sp!.setBool(key, value);
        break;
      case keyLanguage:
        sp!.setString(key, value);
        locale = Locale(sp!.getString(keyLanguage)!, '');
        break;
      case keyIsFirst:
        sp!.setBool(key, value);
        isFirst = sp!.getBool(keyIsFirst);
        break;
      case key24Hour:
        sp!.setBool(key, value);
        is24HourFormat = sp!.getBool(key24Hour);
        break;
    }
    notifyListeners();
  }

  static bool is24HourFormatFromLocale(Locale locale){
    switch(locale.languageCode){
      case "ru":
      case "be":
        return true;
      default:
        return false;
    }
  }

  ThemingMode get theme => ThemingMode(
    themeMode: getThemeMode(currentTheme!),
    accentColor: appColors[currentColorIndex!].accentColor,
    isDarkForAccent: appColors[currentColorIndex!].isDarkForAccent
  );

  Preferences get preferences => Preferences(
    locale: locale,
    isFirst: isFirst,
    theme: currentTheme,
    is24Hour: is24HourFormat
  );

  String? getThemeTitle(BuildContext context) {
    switch (sp!.getString(keyThemeMode)) {
      case 'light':
        return AppLocalizations.of(context, 'theme_light');
      case 'dark':
        return AppLocalizations.of(context, 'theme_dark');
      case 'system':
        return AppLocalizations.of(context, 'theme_system');
      default:
        return "";
    }
  }

  List<DesignColor> get appColors => List.from([
    DesignColor(
      accentColor: const Color(0xFF2259F2),
      isDarkForAccent: false
    ),
    DesignColor(
      accentColor: const Color(0xFFE02B2B),
      isDarkForAccent: false
    ),
    DesignColor(
      accentColor: const Color(0xFFFCC705),
      isDarkForAccent: true
    ),
    DesignColor(
      accentColor: const Color(0xFF288525),
      isDarkForAccent: false
    ),
    DesignColor(
      accentColor: const Color(0xFF4C2AF1),
      isDarkForAccent: false
    ),
    DesignColor(
      accentColor: const Color(0xFFFF6B00),
      isDarkForAccent: true
    ),
    DesignColor(
      accentColor: const Color(0xFF1FA668),
      isDarkForAccent: false
    ),
    DesignColor(
        accentColor: const Color(0xFFB2EE32),
        isDarkForAccent: true
    ),
    DesignColor(
      accentColor: const Color(0xFFE85CBC),
      isDarkForAccent: false
    ),
  ]);
}

class ThemingMode{
  Color? accentColor;
  bool? isDarkForAccent;
  ThemeMode? themeMode;

  ThemingMode({
    this.themeMode,
    this.accentColor,
    this.isDarkForAccent
  });
}

class DesignColor{
  Color? accentColor;
  bool? isDarkForAccent;

  DesignColor({
    this.accentColor,
    this.isDarkForAccent
  });
}
