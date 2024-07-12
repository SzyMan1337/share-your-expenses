import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  StorageService._();
  static final StorageService _service = StorageService._();
  factory StorageService() => _service;

  static StorageService get instance => _service;

  Future<String> uploadFile(file) async {
    final randomId = const Uuid().v4().toString();
    TaskSnapshot snapshot = await _firebaseStorage
        .ref()
        .child('expenses/$randomId')
        .putFile(file);
    return snapshot.ref.getDownloadURL();
  }
}
