import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/web/home/home.screen.web.dart';
import 'package:movie_app/views/web/home/widgets/sign.in.button.dart';

class TitleAppBar extends StatelessWidget with PreferredSizeWidget {
  const TitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var isMobileWeb = context.appProvider.isMobileApp;
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: !isMobileWeb
          ? GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreenWeb.routeName, (route) => false);
              },
              child: SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "MovieVerse",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
      actions: const [
        Center(
          child: SigninButton(),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
