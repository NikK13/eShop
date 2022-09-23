import 'package:e_shop/domain/utils/constants.dart';
import 'package:flutter/material.dart';

class Fragment extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Widget? actions;

  const Fragment({
    Key? key,
    this.actions,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: SingleChildScrollView(
        physics: isIosApplication ?
        const BouncingScrollPhysics() :
        const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                if(actions != null) actions!
              ],
            ),
            const SizedBox(height: 16),
            child!
          ],
        ),
      ),
    );
  }
}
