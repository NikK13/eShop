import 'package:e_shop/domain/utils/app.dart';
import 'package:e_shop/feature/ui/login/login_mobile.dart';
import 'package:e_shop/feature/ui/onboard/onboard_mobile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.setupBar(Theme.of(context).brightness == Brightness.light);
    switch(defaultTargetPlatform){
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return const LoginPageMobile();
      default:
        return const LoginPageMobile();
    }
  }
}