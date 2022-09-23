import 'package:e_shop/domain/utils/app.dart';
import 'package:e_shop/domain/utils/appnavigator.dart';
import 'package:e_shop/domain/utils/localization.dart';
import 'package:e_shop/domain/utils/styles.dart';
import 'package:e_shop/feature/bloc/fb_bloc.dart';
import 'package:e_shop/feature/provider/prefsprovider.dart';
import 'package:e_shop/feature/ui/home/home.dart';
import 'package:e_shop/feature/ui/login/login.dart';
import 'package:e_shop/feature/ui/onboard/onboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

late PackageInfo appInfo;
late FirebaseBloc firebaseBloc;
late PreferenceProvider prefsProvider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalizations.loadLanguages();
  await Firebase.initializeApp();
  firebaseBloc = FirebaseBloc();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PreferenceProvider()),
      ],
      child: Application(),
    ),
  );
  appInfo = await PackageInfo.fromPlatform();
}

class Application extends StatelessWidget {
  Application({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final HeroController _heroController = HeroController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceProvider>(
      builder: (ctx, provider, child) {
        prefsProvider = provider;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          navigatorKey: _navigatorKey,
          onGenerateRoute: (_) => null,
          locale: provider.preferences.locale,
          localizationsDelegates: App.delegates,
          supportedLocales: App.supportedLocales,
          themeMode: getThemeMode(provider.currentTheme ?? "system"),
          theme: themeLight,
          darkTheme: themeDark,
          builder: (context, child){
            return provider.isFirst != null ? AppNavigator(
              navigatorKey: _navigatorKey,
              initialPages: const [
                MaterialPage(child: InitializePage())
              ],
              observers: [_heroController],
            ) : const Scaffold(
              body: Center(
                child: Text(
                  "Loading..."
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class InitializePage extends StatelessWidget {
  const InitializePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreferenceProvider>(context);
    if(provider.isFirst!){
      return OnBoard(preferences: provider.preferences);
    }
    else{
      if(firebaseBloc.fbAuth.currentUser == null){
        return const LoginPage();
      }
      return const HomePage();
    }
  }
}

