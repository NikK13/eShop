import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget? child;
  final String? image;
  final BoxFit fit;
  final double darkness;

  const BackgroundWidget({
    Key? key,
    this.child,
    this.image,
    this.darkness = 0.85,
    this.fit = BoxFit.cover
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            image ?? "assets/images/wallpaper.jpg",
          ),
          fit: fit,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(darkness), BlendMode.darken)
        )
      ),
      child: child,
    );
  }
}
