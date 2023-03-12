import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/firebase_options.dart';
import 'package:movie_app/provider/providers.dart';
import 'package:movie_app/utils/routes.dart';
import 'package:movie_app/views/common/not.network.screen.dart';
import 'package:movie_app/views/mobile/splash.screen/splash.screen.dart';
import 'package:movie_app/views/web/home/home.screen.web.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //   androidProvider: AndroidProvider.playIntegrity,
  // );
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    if (kIsWeb) {
      runApp(const WebApp(isMobileWeb: true));
    } else {
      runApp(const MobileApp());
    }
  } else {
    runApp(const WebApp());
  }
}

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: StreamBuilder(
          initialData: ConnectivityResult.wifi,
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? (snapshot.data == ConnectivityResult.mobile ||
                        snapshot.data == ConnectivityResult.wifi)
                    ? MaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'Movie App',
                        routes: routes,
                        theme: ThemeData(
                          primarySwatch: Colors.red,
                        ),
                        home: const SplashScreenMobile(),
                      )
                    : MaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'Movie App',
                        routes: routes,
                        theme: ThemeData(
                          primarySwatch: Colors.red,
                        ),
                        home: const NoNetworkScreen(),
                      )
                : MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Movie App',
                    routes: routes,
                    theme: ThemeData(
                      primarySwatch: Colors.red,
                    ),
                    home: const NoNetworkScreen(),
                  );
          }),
    );
  }
}

class WebApp extends StatelessWidget {
  const WebApp({
    super.key,
    this.isMobileWeb = false,
  });

  final bool isMobileWeb;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        routes: routes,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomeScreenWeb(isMobileWeb: isMobileWeb),
      ),
    );
  }
}
