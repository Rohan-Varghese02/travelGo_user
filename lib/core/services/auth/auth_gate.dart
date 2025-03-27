import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelgo_user/features/view/screens/home_screen/home_screen.dart';
import 'package:travelgo_user/features/view/screens/login_screen/login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}