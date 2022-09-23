import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  static Map<String, String>? jsonEn;
  static Map<String, String>? jsonRu;
  static Map<String, String>? jsonBy;

  AppLocalizations(this.locale);

  static Future loadLanguages() async{
    if(jsonEn == null || jsonRu == null){
      debugPrint("Loading language configs...");
      jsonEn = Map<String, String>.from(json.decode(await rootBundle.loadString('lib/data/lang/en.json')));
      jsonRu = Map<String, String>.from(json.decode(await rootBundle.loadString('lib/data/lang/ru.json')));
      jsonBy = Map<String, String>.from(json.decode(await rootBundle.loadString('lib/data/lang/by.json')));
    }
  }

  static LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': jsonEn!,
    'ru': jsonRu!,
    'be': jsonBy!,
  };

  String get langCode => locale.languageCode.toString();

  String translate(key) => _localizedValues[locale.languageCode]![key]!;

  static String of(BuildContext context, String key) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!
          .translate(key);
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'ru', 'be'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
