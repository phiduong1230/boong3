import 'package:boong3/services/auth.dart';
import 'package:boong3/utils/color.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        color: mainColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // image
            Image.asset("asset/images/icon_trans.png"),
            const Spacer(),
            // Signin option
            ElevatedButton(
              style: ButtonStyle(
                splashFactory: InkSplash.splashFactory,
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(12),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.g_mobiledata,
                    size: 40,
                    color: mainColor,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                          color: mainColor,
                          fontFamily: 'Bellota',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                print("clicked");
                AuthServices().signInWithGoogle(context);
              },
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
