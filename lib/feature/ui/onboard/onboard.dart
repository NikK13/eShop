import 'package:e_shop/domain/model/preferences.dart';
import 'package:e_shop/domain/utils/app.dart';
import 'package:e_shop/feature/ui/onboard/onboard_mobile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OnBoard extends StatelessWidget {
  final Preferences? preferences;

  const OnBoard({Key? key, this.preferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.setupBar(Theme.of(context).brightness == Brightness.light);
    switch(defaultTargetPlatform){
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return OnBoardMobile(prefs: preferences);
      default:
        return OnBoardMobile(prefs: preferences);
    }
  }
}