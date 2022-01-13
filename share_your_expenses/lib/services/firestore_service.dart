import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_your_expenses/enums/role.dart';

import '../api_path.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirestoreService._();
  static final FirestoreService _service = FirestoreService._();
  factory FirestoreService() => _service;

  static FirestoreService get instance => _service;

  Future<void> createUser(
      String userId, List<UserRole> roles, String userName) async {
    try {
      final String path = ApiPath.user(userId);
      final DocumentReference document = _firebaseFirestore.doc(path);
      await document.set(
        {
          'roles': roles.map((role) => role.name).toList(),
          'userName': userName,
          'groupsIds': List<String>.empty()
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      log('Create User Error');
    }
  }

  //Future<void> createGroup(String groupName, String description, )

  // Future<User> getUser(String userId) async {
  //   final String path = ApiPath.user(userId);
  //   final DocumentSnapshot document = await _firebaseFirestore.doc(path).get();
  //   final Map<String, dynamic> json = document.data();

  //   return User.fromJson(json);
  // }
}
