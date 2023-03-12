import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/utils/dialogs.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/mobile/home/home.screen.dart';
import 'package:movie_app/views/mobile/splash.screen/splash.screen.scaffold.dart';

class SplashScreenMobile extends StatefulWidget {
  const SplashScreenMobile({super.key});
  static const routeName = "/splash";

  @override
  State<SplashScreenMobile> createState() => _SplashScreenStateMobile();
}

class _SplashScreenStateMobile extends State<SplashScreenMobile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (FirebaseAuth.instance.currentUser == null) {
        await Dialogs.showGetStartedDialog(context);
      } else {
        context.authProvider.updateGuestUser(false);
        Navigator.pushReplacementNamed(context, HomeScreenMobile.routeName);
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
