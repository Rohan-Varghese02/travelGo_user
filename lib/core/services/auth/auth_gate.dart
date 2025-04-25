import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/main_screen/main_screen.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/home_page.dart';
import 'package:travelgo_user/features/view/screens/auth_screens/login_screen/login_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Future<Widget> checkUserRole(User user) async {
    final docSnapshot =
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data()!;
      final role = docSnapshot.data()!['role'];
      if (role == 'user') {
        final userData = UserDataModel.fromMap(data);

        return MainScreen(userdata: userData);
      } else {
        return LoginScreen();
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Access Denied: You are not an user."),
            backgroundColor: Colors.red,
          ),
        );
        await FirebaseAuth.instance.signOut();
      });
      return LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<Widget>(
              future: checkUserRole(snapshot.data!),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (roleSnapshot.hasData) {
                  return roleSnapshot.data!;
                } else {
                  return const LoginScreen();
                }
              },
            );
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
