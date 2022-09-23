import 'package:e_shop/domain/utils/localization.dart';
import 'package:e_shop/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget get noPictureYet => Container(
  decoration: BoxDecoration(
    color: Colors.grey.shade700,
  ),
  child: Center(
    child: FittedBox(
      child: Icon(
        CupertinoIcons.car_detailed,
        color: Colors.grey.shade900,
        size: 130,
      ),
    ),
  ),
);


Widget noStatsYet(BuildContext context){
  return Padding(
    padding: const EdgeInsets.only(bottom: 40),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.car_detailed,
            color: prefsProvider.theme.accentColor,
            size: 150,
          ),
          Text(
            AppLocalizations.of(context, 'empty_now'),
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}