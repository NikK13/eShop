import 'package:e_shop/domain/utils/constants.dart';
import 'package:e_shop/domain/utils/localization.dart';
import 'package:e_shop/feature/widgets/general/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({
    Key? key,
    @required this.navigatorKey,
    @required this.initialPages,
    @required this.observers,
  }) : super(key: key);

  final GlobalKey<NavigatorState>? navigatorKey;
  final List<Page<Object>>? initialPages;
  final List<NavigatorObserver>? observers;

  static AppNavigatorState of(BuildContext context) {
    return context.findAncestorStateOfType<AppNavigatorState>()!;
  }

  @override
  AppNavigatorState createState() => AppNavigatorState();
}

class AppNavigatorState extends State<AppNavigator> {
  final _stack = <Page>[];

  bool _exit = false;

  @override
  void initState() {
    _stack.addAll(widget.initialPages!);
    super.initState();
    assert(widget.initialPages!.isNotEmpty);
  }

  Future closeThenPush(Widget child) async{
    setState((){
      _stack.clear();
      _stack.add(!isIosApplication ?
      MaterialPage(child: child) :
      CupertinoPage(child: child));
    });
    //debugPrint("$_stack");
  }

  Future push(Widget child) async{
    setState((){
      _stack.add(
        !isIosApplication ?
        MaterialPage(child: child) :
        CupertinoPage(child: child)
      );
    });
    //debugPrint("$_stack");
  }

  Future pop({BuildContext? ctx}) async {
    if (_stack.length > 1) {
      setState(() => _stack.removeLast());
      return true;
    }
    else{
      if (_exit) {
        return true;
      }
      _exit = true;
      Toast.show(
        context: ctx,
        text: AppLocalizations.of(ctx!, 'exit_app'),
        icon: const Icon(Icons.exit_to_app, color: Colors.white)
      );
      Future.delayed(const Duration(seconds: 3)).then((_) {
        _exit = false;
      });
      return false;
    }
  }

  bool add(Page page, Page afterPage) {
    final index = _stack.indexOf(afterPage);
    if (index == -1) {
      return false;
    }
    setState(() => _stack.insert(index + 1, page));
    return true;
  }

  bool remove(Page page) {
    final index = _stack.indexOf(page);
    if (index == -1) {
      return false;
    }
    setState(() => _stack.remove(page));
    return true;
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    remove(route.settings as Page);
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    //print('AppNavigator: ${_stack.length}');
    return Navigator(
      observers: widget.observers!,
      key: widget.navigatorKey,
      onPopPage: _onPopPage,
      pages: List.unmodifiable(_stack),
    );
  }
}
