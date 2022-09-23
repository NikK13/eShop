import 'package:e_shop/domain/utils/constants.dart';
import 'package:e_shop/domain/utils/styles.dart';
import 'package:e_shop/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformButton extends StatelessWidget {
  final String? text;
  final double fontSize;
  final Function()? onPressed;
  final Function? onLongPress;
  final double borderRadius;

  const PlatformButton({
    Key? key,
    @required this.text,
    this.fontSize = 20,
    @required this.onPressed,
    this.onLongPress,
    this.borderRadius = 16
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isIosApplication) {
      return CupertinoButton(
        onPressed: onPressed!,
        color: prefsProvider.theme.accentColor,
        padding: const EdgeInsets.all(10),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.6,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              text!,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                fontFamily: appFont,
                color: prefsProvider.theme.isDarkForAccent! ?
                Colors.black : Colors.white,
              ),
              textAlign: TextAlign.center,
            )
          ),
        ),
      );
    }
    return ElevatedButton(
      onPressed: onPressed!,
      onLongPress: () => onLongPress != null ?
      onLongPress!() : (){},
      style: ElevatedButton.styleFrom(
        backgroundColor: prefsProvider.theme.accentColor,
        textStyle: const TextStyle(
          fontFamily: appFont,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        )
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.7,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            text!,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: prefsProvider.theme.isDarkForAccent! ?
              Colors.black : Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
      )
    );
  }
}
