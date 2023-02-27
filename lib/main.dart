import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/firebase_options.dart';
import 'package:movie_app/provider/providers.dart';
import 'package:movie_app/utils/routes.dart';
import 'package:movie_app/views/common/not.network.screen.dart';
import 'package:movie_app/views/splash.screen/splash.screen.dart';
import 'package:movie_app/views/splash.screen/splash.screen.scaffold.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: StreamBuilder<ConnectivityResult>(
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
                        home: const SplashScreen(),
                      )
                    : const NoNetworkScreen()
                : MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Movie App',
                    routes: routes,
                    theme: ThemeData(
                      primarySwatch: Colors.red,
                    ),
                    builder: (context, child) {
                      return const SplashScreenScaffold();
                    },
                  );
          }),
    );
  }
}
