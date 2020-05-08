
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository{
  final FirebaseStorage _firebaseStorage;

  StorageRepository({FirebaseStorage firebaseStorage})
  : _firebaseStorage = firebaseStorage ?? FirebaseStorage();

}