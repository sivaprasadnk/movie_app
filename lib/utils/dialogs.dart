import 'package:flutter/material.dart';

class Dialogs {
  static void showLoader({required BuildContext context}) async {
    showDialog(
      context: context,
      // barrierColor: Colors.white,
      barrierDismissible: false,
      builder: ((context) {
        return WillPopScope(
          onWillPop: (() async => false),
          child: const Dialog(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      }),
    );
  }
}
