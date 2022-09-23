import 'package:e_shop/domain/utils/constants.dart';
import 'package:e_shop/domain/utils/localization.dart';
import 'package:e_shop/domain/utils/styles.dart';
import 'package:e_shop/feature/widgets/navigation/ios_nav_bar.dart';
import 'package:e_shop/feature/widgets/navigation/material_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformNavBar extends StatelessWidget {
  final double fontSize;
  final bool? isWithTitle;
  final double height;
  final double iconSize;
  final Color? shadowColor;
  final Color? color;
  final Color? selectedColor;
  final ValueChanged<int?>? onTabSelected;

  const PlatformNavBar({
    Key? key,
    this.fontSize = 14.0,
    this.height = 55.0,
    this.iconSize = 24.0,
    this.color,
    this.selectedColor,
    this.onTabSelected,
    this.shadowColor,
    this.isWithTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isIosApplication ? MaterialBar(
      color: color,
      backgroundColor: Theme.of(context).brightness == Brightness.light ?
      colorLight : colorDark,
      shadowColor: shadowColor,
      selectedColor: selectedColor,
      isWithTitle: isWithTitle,
      iconSize: 26,
      onTabSelected: onTabSelected,
      items: materialItems(context),
    ) : IosNavigationBar(
      color: color,
      backgroundColor: Theme.of(context).brightness == Brightness.light ?
      colorLight : colorDark,
      shadowColor: shadowColor,
      selectedColor: selectedColor,
      isWithTitle: isWithTitle,
      iconSize: 26,
      onTabSelected: onTabSelected,
      items: iosItems(context),
    );
  }

  List<MaterialBarItem> materialItems(BuildContext context) => [
    MaterialBarItem(
      iconData: CupertinoIcons.home,
      selectedIconData: CupertinoIcons.house_fill,
      text: AppLocalizations.of(context, 'home'),
    ),
    MaterialBarItem(
      iconData: CupertinoIcons.car_detailed,
      text: AppLocalizations.of(context, 'vehicles'),
    ),
  ];

  List<IosBarItem> iosItems(BuildContext context) => [
    IosBarItem(
      iconData: CupertinoIcons.home,
      text: AppLocalizations.of(context, 'home'),
    ),
    IosBarItem(
      iconData: CupertinoIcons.car_detailed,
      text: AppLocalizations.of(context, 'vehicles'),
    ),
  ];
}
