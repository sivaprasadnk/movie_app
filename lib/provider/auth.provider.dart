import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/repo/auth/auth.repo.dart';
import 'package:movie_app/utils/custom.exception.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/mobile/home/home.screen.dart';
import 'package:movie_app/views/mobile/splash.screen/splash.screen.dart';
import 'package:movie_app/views/web/home/home.screen.web.dart';

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
      context.unfocus();

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
        context.pop();
        Navigator.pushReplacementNamed(context, HomeScreenMobile.routeName);
      }
    } on CustomException catch (exc) {
      context.pop();

      context.scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(exc.message),
      ));
    } on FirebaseAuthException catch (e) {
      context.pop();

      var message = "";
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      } else {
        message = e.code;
      }
      context.scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future signIn(
    String emailAddress,
    String password,
    BuildContext context,
    bool isApp,
  ) async {
    try {
      context.unfocus();
      if (emailAddress.isEmpty) {
        throw CustomException('Email Address cannot be empty !');
      }
      if (password.isEmpty) {
        throw CustomException('Password cannot be empty !');
      }

      await AuthRepo.signIn(emailAddress, password).then((userCredential) {
        if (userCredential != null) {
          context.pop();
          updateGuestUser(false);
          if (isApp) {
            Navigator.pushReplacementNamed(context, HomeScreenMobile.routeName);
          } else {
            Navigator.pushReplacementNamed(context, HomeScreenWeb.routeName);
          }
        } else {
          context.pop();
        }
      });
    } on CustomException catch (exc) {
      context.pop();

      final snackBar = SnackBar(
        content: Text(exc.message),
      );

      context.scaffoldMessenger.showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      context.pop();
      debugPrint(e.message);
      var message = "";
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      } else {
        message = e.code;
      }
      context.scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future logout(BuildContext context) async {
    await AuthRepo.logout().then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, SplashScreenMobile.routeName, (route) => false);
    });
  }

  Future signInWithMobile(BuildContext context, String mobile) async {
    try {
      context.unfocus();

      // await AuthRepo.phoneSignIn(mobile);
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          // phoneNumber: '+918086028340',
          phoneNumber: '+91$mobile',
          verificationCompleted: (phoneAuthCredential) {
            debugPrint('verificationCompleted :');
          },
          verificationFailed: (error) {
            debugPrint('verificationFailed :');
            debugPrint(error.toString());
            context.scaffoldMessenger.showSnackBar(
              SnackBar(content: Text(error.toString())),
            );
          },
          codeSent: (verificationId, forceResendingToken) {
            debugPrint('codeSent : $verificationId');
            context.scaffoldMessenger.showSnackBar(
              SnackBar(content: Text('codeSent : $verificationId')),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {
            debugPrint('codeAutoRetrievalTimeout :');
          },
        );
        return;
      } on FirebaseAuthException catch (err) {
        debugPrint(err.message);
        debugPrint(err.code);
        debugPrint(err.toString());
      } catch (err) {
        debugPrint(err.toString());
      }
    } on CustomException catch (exc) {
      context.pop();

      final snackBar = SnackBar(
        content: Text(exc.message),
      );

      context.scaffoldMessenger.showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      context.pop();
      debugPrint(e.message);
      var message = "";
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      } else {
        message = e.code;
      }
      context.scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
