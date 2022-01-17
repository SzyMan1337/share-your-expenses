import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  StorageService._();
  static final StorageService _service = StorageService._();
  factory StorageService() => _service;

  static StorageService get instance => _service;
}
