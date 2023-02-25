import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/auth/sign.in/sign.in.screen.dart';
import 'package:movie_app/views/common/common.button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signUp';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String confirmPassword = "";
  String userName = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 80),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Enter your user information below or continue with one of your social accounts',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  onSaved: (newValue) {
                    userName = newValue!.trim();
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    label: const Text("Name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onSaved: (newValue) {
                    email = newValue!.trim();
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    label: const Text("Email"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onSaved: (newValue) {
                    password = newValue!.trim();
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    label: const Text("Password"),
                    suffixIcon: const Icon(
                      Icons.visibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onSaved: (newValue) {
                    confirmPassword = newValue!.trim();
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    label: const Text("Confirm password"),
                    suffixIcon: const Icon(
                      Icons.visibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "By signing up, you accept Privacy Policy & Terms of Service",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                CommonButton(callback: validateAndProceed, title: 'Sign Up'),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: "Already have an account ? ",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign in',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, SignInScreen.routeName);
                          },
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateAndProceed() async {
    _formKey.currentState!.save();
    // await context.authProvider.register(
    //   email,
    //   password,
    //   confirmPassword,
    //   userName,
    //   context,
    // );
    await context.authProvider.register(
      'sivaprasadnk123@gmail.com',
      '123456789',
      '123456789',
      'userName',
      context,
    );
  }
}
