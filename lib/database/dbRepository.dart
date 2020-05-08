import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:scriptum/models/note.dart';
import 'package:scriptum/models/user.dart';

class DBRepository {
  final Firestore _firestore;

  DBRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  Future<void> initialiseUser(User user) async {
    return await _firestore.collection('users').document(user.uid).setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
    });
  }

  Future<Map<String, dynamic>> getUserDetails(User user) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').document(user.uid).get();
    return snapshot.data;
  }

  Future<void> uploadNoteData(User user, Note note) async {
    await _firestore
        .collection('users')
        .document(user.uid)
        .collection('notes')
        .document(note.id)
        .setData(note.tomap());
  }

  Future<void> addTag(User user, String tag) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').document(user.uid).get();
    List<String> tags = snapshot.data['tags'];
    tags.add(tag);
    Map<String, dynamic> updates = {
      'tags': tags,
    };
    await _firestore.collection('users').document(user.uid).updateData(updates);
  }

  Future<List<Map<String, dynamic>>> getFromTags(String tag, String uid) async {
    QuerySnapshot qSnapshot = await _firestore
        .collectionGroup('notes')
        .where('tags', arrayContains: tag)
        .where('uid', isEqualTo: uid)
        .getDocuments();
    List<Map<String, dynamic>> notes;

    qSnapshot.documents.forEach((DocumentSnapshot element) {
      notes.add(element.data);
    });

    return notes;
  }
}
