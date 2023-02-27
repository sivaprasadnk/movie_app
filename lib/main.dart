import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/firebase_options.dart';
import 'package:movie_app/provider/providers.dart';
import 'package:movie_app/utils/routes.dart';
import 'package:movie_app/views/splash.screen.dart';
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
            return snapshot.data == ConnectivityResult.mobile ||
                    snapshot.data == ConnectivityResult.wifi
                ? MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Movie App',
                    routes: routes,
                    theme: ThemeData(
                      primarySwatch: Colors.red,
                    ),
                    home: const SplashScreen(),
                  )
                : MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Movie App',
                    routes: routes,
                    theme: ThemeData(
                      primarySwatch: Colors.red,
                    ),
                    builder: (context, child) {
                      return Scaffold(
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.network_check_rounded, size: 40),
                              SizedBox(height: 20),
                              Text(
                                "No Network Connection !",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Please check your connection and try again.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
