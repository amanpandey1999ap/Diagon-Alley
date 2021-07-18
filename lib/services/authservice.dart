import 'package:diagon_alley/screens/home_page.dart';
import 'package:diagon_alley/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        // stream: FirebaseAuth.instance.onAuthStateChanged(),
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print("home pr jaa rha h");
            return HomePage();
          } else {
            print("login pr jaa rha h");
            return LoginPage();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}