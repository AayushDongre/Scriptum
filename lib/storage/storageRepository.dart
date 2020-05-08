import 'package:firebase_storage/firebase_storage.dart';
import 'package:scriptum/models/note.dart';
import 'package:scriptum/models/user.dart';

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage();

  Future<bool> uploadNote(User user, Note note) async {
    StorageUploadTask task =  _firebaseStorage.ref().child('${user.uid}/${note.id}').putFile(note.file);
    return task.isComplete;
  }
}
