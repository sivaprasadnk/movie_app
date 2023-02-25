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

  // UserCredential? _userCredential;
  // UserCredential? get userCredential => _userCredential;

  // void updateUser(UserCredential user) {
  //   _userCredential = user;
  //   notifyListeners();
  // }

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
      updateGuestUser(false);

      await AuthRepo.register(emailAddress, password, userName);
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    } on CustomException catch (exc) {
      context.scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(exc.message),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        context.scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        context.scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
      }
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
          updateGuestUser(false);
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
