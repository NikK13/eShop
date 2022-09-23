import 'package:e_shop/domain/utils/constants.dart';
import 'package:e_shop/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshView extends StatelessWidget {
  final Widget? child;
  final Function? updateCurrentDate;
  final ScrollController? scrollController;

  const RefreshView({
    Key? key,
    this.child,
    this.updateCurrentDate,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isIosApplication
      ? RefreshIndicator(
        color: prefsProvider.theme.accentColor,
        onRefresh: updateCurrentDate as Future<void> Function(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          child: child,
        ),
      )
      : CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: updateCurrentDate as Future<void> Function(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, _) => child,
              childCount: 1,
            ),
          )
        ],
      );
  }
}
