import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class DBRepository {
  final Firestore _firestore;

  DBRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  Future<void> initialiseUser(String uid) async {
    await _firestore.collection('users').document(uid).setData({
      'uid': uid,
    });
  }

  
}
