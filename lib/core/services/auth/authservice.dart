import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelgo_user/data/models/user_data.dart';

class Authservice {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ///----- Signin With Email and Password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        email: email,
      );

      firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

      firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'role': 'user',
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }

  ///--- Sigin with Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    UserCredential userCredential = await firebaseAuth.signInWithCredential(
      credential,
    );
    log(userCredential.user!.displayName.toString());
    UserModel userModel = UserModel(
      uid: userCredential.user!.uid,
      email: userCredential.user!.email!,
    );
    await firestore
        .collection("Users")
        .doc(userModel.uid)
        .set(userModel.toMap());
    // firestore.collection('Users').doc(userCredential.user!.uid).set({
    //   'uid': userCredential.user!.uid,
    //   'email': userCredential.user!.email,
    //   'role': 'user',
    // });
    return userCredential;
  }
}
