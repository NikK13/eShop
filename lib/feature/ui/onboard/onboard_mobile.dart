import 'package:e_shop/domain/model/preferences.dart';
import 'package:e_shop/domain/utils/app.dart';
import 'package:e_shop/domain/utils/constants.dart';
import 'package:e_shop/domain/utils/localization.dart';
import 'package:e_shop/feature/provider/prefsprovider.dart';
import 'package:e_shop/feature/widgets/animation/show_up.dart';
import 'package:e_shop/feature/widgets/platform/platform_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardMobile extends StatefulWidget {
  final Preferences? prefs;

  const OnBoardMobile({Key? key, this.prefs}) : super(key: key);

  @override
  State<OnBoardMobile> createState() => _OnBoardMobileState();
}

class _OnBoardMobileState extends State<OnBoardMobile> {

  Future proceedToApp(context, provider) async {
    await provider
      ..savePreference(keyLanguage, widget.prefs!.locale!.languageCode)
      ..savePreference(keyIsFirst, false)
      ..savePreference(key24Hour, PreferenceProvider.is24HourFormatFromLocale(widget.prefs!.locale!));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreferenceProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Icon(
                    Icons.shopping_basket_outlined,
                    size: 200,
                    color: provider.theme.accentColor,
                  ),
                ),
              ),
              ShowUpAnimated(
                delay: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32
                  ),
                  child: Column(
                    children: [
                      const FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          App.appName,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          AppLocalizations.of(context, 'desc'),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
              SizedBox(
                height: 120,
                child: Center(
                  child: PlatformButton(
                    text: AppLocalizations.of(context, 'start'),
                    onPressed: () async {
                      await proceedToApp(context, provider);
                    },
                  )
                )
              ),
              const SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }
}


