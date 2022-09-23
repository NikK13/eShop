import 'package:e_shop/domain/utils/styles.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final Color? color;
  final String? title;
  final double fontSize;

  const AppTitle({
    Key? key,
    this.title,
    this.color,
    this.fontSize = 32
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          title!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            fontFamily: appFont,
            letterSpacing: 2.5,
            //color: provider.theme.accentColor!,
            foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4
            ..color = color!.withOpacity(0.4)
          ),
        ),
        Text(
          title!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            fontFamily: appFont,
            letterSpacing: 2.5,
            color: color!,
          ),
        ),
      ],
    );
  }
}
