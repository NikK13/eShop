import 'package:e_shop/domain/utils/app.dart';
import 'package:e_shop/domain/utils/appnavigator.dart';
import 'package:e_shop/feature/provider/prefsprovider.dart';
import 'package:e_shop/feature/ui/home/home_mobile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<PreferenceProvider>(context);
    App.setupBar(Theme.of(context).brightness == Brightness.light);
    switch(defaultTargetPlatform){
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return WillPopScope(
          onWillPop: () async => await AppNavigator.of(context).pop(ctx: context),
          child: HomePageMobile(provider: homeProvider)
        );
      default:
        return HomePageMobile(provider: homeProvider);
    }
  }
}