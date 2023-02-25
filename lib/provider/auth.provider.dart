import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/repo/auth/auth.repo.dart';
import 'package:movie_app/utils/custom.exception.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/home/home.screen.dart';
import 'package:movie_app/views/splash.screen.dart';

class AuthProvider extends ChangeNotifier {
  bool _isGuestUser = true;
  bool get isGuestUser => _isGuestUser;

  void updateGuestUser(bool value) {
    _isGuestUser = value;
    notifyListeners();
  }

  UserCredential? _userCredential;
  UserCredential? get userCredential => _userCredential;

  Future register(String emailAddress, String password, String confirmPassword,
      String userName, BuildContext context) async {
    try {
      if (emailAddress.isEmpty) {
        throw CustomException('Email Address cannot be empty !');
      }
      if (password.isEmpty) {
        throw CustomException('Password cannot be empty !');
      }
      if (password != confirmPassword) {
        throw CustomException("Passwords doesn't match!");
      }
      if (userName.isEmpty) {
        throw CustomException("Username cannot be empty!");
      }

      _userCredential =
          await AuthRepo.register(emailAddress, password, userName);
      if (_userCredential != null) {
        await _userCredential!.user!.updateDisplayName(userName).then((value) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        });
      }
    } on CustomException catch (exc) {
      final snackBar = SnackBar(
        content: Text(exc.message),
      );

      context.scaffoldMessenger.showSnackBar(snackBar);
    }
  }

  Future signIn(
      String emailAddress, String password, BuildContext context) async {
    try {
      if (emailAddress.isEmpty) {
        throw CustomException('Email Address cannot be empty !');
      }
      if (password.isEmpty) {
        throw CustomException('Password cannot be empty !');
      }

      await AuthRepo.signIn(emailAddress, password).then((userCredential) {
        if (userCredential != null) {
          _userCredential = userCredential;
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      });
    } on CustomException catch (exc) {
      final snackBar = SnackBar(
        content: Text(exc.message),
      );

      context.scaffoldMessenger.showSnackBar(snackBar);
    }
  }

  Future logout(BuildContext context) async {
    await AuthRepo.logout().then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, SplashScreen.routeName, (route) => false);
    });
  }
}
