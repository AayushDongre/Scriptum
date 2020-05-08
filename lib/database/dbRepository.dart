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

  Stream<DocumentSnapshot> getUserDetails(User user){
       return _firestore.collection('users').document(user.uid).snapshots();
  }

  Stream<QuerySnapshot> getNotesFromTag(String tag, String uid){
    return _firestore
        .collectionGroup('notes')
        .where('tags', arrayContains: tag)
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
}
