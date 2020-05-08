import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:scriptum/models/note.dart';
import 'package:scriptum/models/user.dart';

class DBRepository {
  final Firestore _firestore;
  final User user;

  DBRepository({Firestore firestore, @required this.user})
      : assert(user != null),
        _firestore = firestore ?? Firestore.instance;

  Future<void> initialiseUser(User user) async {
    return await _firestore.collection('users').document(user.uid).setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
    });
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').document(user.uid).get();
    return snapshot.data;
  }

  Future<void> uploadNoteData(Note note) async {
    await _firestore
        .collection('users')
        .document(user.uid)
        .collection('notes')
        .document(note.id)
        .setData(note.tomap());
  }

  Future getFromTags(String tag) async {
    QuerySnapshot qSnapshot = await _firestore
        .collectionGroup('notes')
        .where('tags', arrayContains: tag)
        .getDocuments();
    List<Map<String, dynamic>> notes; 

    qSnapshot.documents.forEach((DocumentSnapshot element) {
      notes.add(element.data);
    });

    return notes;
  }
}
