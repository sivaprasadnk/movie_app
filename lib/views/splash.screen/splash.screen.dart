import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/utils/dialogs.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/home/home.screen.dart';
import 'package:movie_app/views/splash.screen/splash.screen.scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (FirebaseAuth.instance.currentUser == null) {
        await Dialogs.showGetStartedDialog(context);
      } else {
        context.authProvider.updateGuestUser(false);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: const SplashScreenScaffold(),
    );
  }
}
