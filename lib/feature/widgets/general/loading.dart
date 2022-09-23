import 'package:e_shop/domain/utils/constants.dart';
import 'package:e_shop/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isIosApplication
      ?
      const CupertinoActivityIndicator()
      :
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(prefsProvider.theme.accentColor),
      ),
    );
  }
}
