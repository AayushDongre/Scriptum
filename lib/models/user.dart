import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class User {
  final String email;
  final String name;
  final String uid;

  const User._({
    @required this.uid,
    @required this.email,
    @required this.name,
  });

  factory User.fromFirebaseUser(FirebaseUser user) {
    assert(user != null);
    return User._(uid: user.uid, email: user.email, name: user.displayName);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.email == email &&
      o.name == name &&
      o.uid == uid;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ uid.hashCode;

  @override
  String toString() => 'User(email: $email, name: $name, uid: $uid)';
}
