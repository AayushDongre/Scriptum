import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
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
    if (!tags.contains(tag)) {
      tags.add(tag);
    }
    Map<String, dynamic> updates = {
      'tags': tags,
    };
    await _firestore.collection('users').document(user.uid).updateData(updates);
  }

  Future<void> addTags(User user, List<String> newTags) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').document(user.uid).get();
    List<String> tags = snapshot.data['tags'] ?? [];
    newTags.forEach((element) {
      if (!tags.contains(element)) {
        tags.add(element);
        print(element);
      }
    });
    Map<String, dynamic> updates = {
      'tags': tags,
    };
    await _firestore.collection('users').document(user.uid).updateData(updates);
  }

  Stream<DocumentSnapshot> getUserDetails(User user) {
    return _firestore.collection('users').document(user.uid).snapshots();
  }

  Stream<QuerySnapshot> getNotesFromTag(String tag, String uid) {
    return _firestore
        .collectionGroup('notes')
        .where('tags', arrayContains: tag)
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
}
