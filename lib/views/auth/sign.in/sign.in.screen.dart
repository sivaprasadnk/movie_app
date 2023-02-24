import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/views/auth/sign.up/sign.up.screen.dart';
import 'package:movie_app/views/home/home.screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const routeName = '/signIn';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 80),
              const Text(
                'Sign In',
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
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      //
                    },
                    child: const Text(
                      "Forgot password ?  ",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Don't have an account ? ",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign up',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(
                              context, SignUpScreen.routeName);
                        },
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
