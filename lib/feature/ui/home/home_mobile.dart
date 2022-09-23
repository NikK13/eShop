import 'package:e_shop/domain/utils/appnavigator.dart';
import 'package:e_shop/feature/provider/prefsprovider.dart';
import 'package:e_shop/feature/ui/login/login.dart';
import 'package:e_shop/feature/widgets/platform/platform_button.dart';
import 'package:e_shop/main.dart';
import 'package:flutter/material.dart';

class HomePageMobile extends StatefulWidget {
  final PreferenceProvider? provider;

  const HomePageMobile({
    super.key,
    this.provider,
  });

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  PreferenceProvider get provider => widget.provider!;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: PlatformButton(
            text: "Sign out",
            onPressed: () async{
              firebaseBloc.fbAuth.signOut();
              AppNavigator.of(context).closeThenPush(const LoginPage());
            }
          )
        ),
      ),
    );
  }
}