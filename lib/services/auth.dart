import 'package:boong3/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local.dart';
import 'database.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  getCurrentUser() async {
    print("getting user");
    return _auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn() as GoogleSignInAccount;
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);

    User userDetails = userCredential.user as User;

    await SharedPreferencesHelper().saveUserEmail(userDetails.email.toString());
    await SharedPreferencesHelper().saveUsername(
      userDetails.email.toString().replaceAll('@gmail.com', ''),
    );
    await SharedPreferencesHelper().saveUserId(userDetails.uid);
    await SharedPreferencesHelper()
        .saveDisplayName(userDetails.displayName.toString());
    await SharedPreferencesHelper()
        .saveUserProfileUrl(userDetails.photoURL.toString());

    Map<String, dynamic> userInfoMap = {
      "email": userDetails.email,
      "username": userDetails.email!.replaceAll("@gmail.com", ""),
      "name": userDetails.displayName,
      "imgUrl": userDetails.photoURL,
    };
    // Cập nhật thông tin của người dùng lên database
    DatabaseMethods()
        .addUserInfoToDatabase(userDetails.uid, userInfoMap)
        .then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ),
      );
    });
  }

  
    // Đăng xuất
    Future signOutServices() async {
      SharedPreferences prefss = await SharedPreferences.getInstance();
      //Xoá dữ liệu tạm thời
      await prefss.clear();
      //Đăng xuất khỏi tài khoản google
      await _auth.signOut().then((_) {
        _googleSignIn.signOut();
      });
    }
}
