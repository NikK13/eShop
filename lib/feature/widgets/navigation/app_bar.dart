import 'package:e_shop/domain/utils/appnavigator.dart';
import 'package:e_shop/domain/utils/constants.dart';
import 'package:flutter/material.dart';

class PlatformAppBar extends StatelessWidget {
  final String? title;
  final double titleFontSize;
  final Widget? actions;

  const PlatformAppBar({
    Key? key,
    this.title,
    this.actions,
    this.titleFontSize = 16
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isIosApplication ? Row(
      children: [
        const SizedBox(width: 4),
        GestureDetector(
          onTap: (){
            AppNavigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.light
              ? Colors.black : Colors.white,
            size: 30,
          )
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600
              ),
              maxLines: 1,
            ),
          ),
        ),
        const SizedBox(width: 16),
        if(actions != null)
        actions!
      ],
    ) : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: GestureDetector(
            onTap: (){
              AppNavigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light
                ? Colors.black : Colors.white,
              size: 20,
            )
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        if(actions != null)
        actions!
        else
        const SizedBox(width: 35),
      ],
    );
  }
}
