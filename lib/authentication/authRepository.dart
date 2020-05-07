import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scriptum/models/user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();


  Future<User> signUpWithEmailAndPassword(String email, String password, String name) async {
    AuthResult result  = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = name;
    await result.user.updateProfile(updateInfo);
    FirebaseUser user = await _firebaseAuth.currentUser();
    return User.fromFirebaseUser(user);
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser user = await _firebaseAuth.currentUser();
    return User.fromFirebaseUser(user);
  }

  Future<User> signInWithCredentials(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return User.fromFirebaseUser(authResult.user);
  }

  Future<void> logout() async {
    return _firebaseAuth.signOut();
  }

  Future<bool> isSignIn() async {
    final user = await _firebaseAuth.currentUser();
    return user != null;
  }

  Future<User> getCurrentUser() async {
    final FirebaseUser  currentUser = await _firebaseAuth.currentUser();
    return User.fromFirebaseUser(currentUser);
  }
}
