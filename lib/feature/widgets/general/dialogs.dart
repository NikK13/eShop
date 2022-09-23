import 'package:e_shop/domain/utils/constants.dart';
import 'package:e_shop/domain/utils/localization.dart';
import 'package:e_shop/domain/utils/styles.dart';
import 'package:e_shop/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showActionsDialog(context, title, content, posTitle, posAction){
  if(isIosApplication){
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: appFont
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: appFont
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context, 'cancel'),
              style: TextStyle(
                color: prefsProvider.theme.accentColor,
                fontWeight: FontWeight.w500,
                fontFamily: appFont
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async{
              Navigator.pop(context);
              await posAction!();
            },
            child: Text(
              posTitle,
              style: TextStyle(
                color: prefsProvider.theme.accentColor,
                fontWeight: FontWeight.w500,
                fontFamily: appFont
              ),
            ),
          ),
        ],
      )
    );
  }
  else{
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: appFont
          ),
        ),
        content:  Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              AppLocalizations.of(context, 'cancel'),
              style: TextStyle(
                color: prefsProvider.theme.accentColor
              ),
            ),
            onPressed: () => Navigator.pop(context)
          ),
          TextButton(
            child: Text(
              posTitle,
              style: TextStyle(
                color: prefsProvider.theme.accentColor
              ),
            ),
            onPressed: () async{
              Navigator.pop(context);
              await posAction!();
            },
          ),
        ],
      )
    );
  }
}