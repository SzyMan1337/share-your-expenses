import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_your_expenses/enums/role.dart';
import 'package:share_your_expenses/models/group.dart';
import 'package:share_your_expenses/models/user.dart';

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

  Future<User> getUser(String userId) async {
    final String path = ApiPath.user(userId);
    final DocumentSnapshot document = await _firebaseFirestore.doc(path).get();
    final Map<String, dynamic> json = document.data() as Map<String, dynamic>;

    return User.fromJson(json);
  }

  Future<void> createGroup(
      String groupName, String description, String userId) async {
    try {
      List<String> members = [userId];
      final String groupsPath = ApiPath.groups;

      DocumentReference _docRef = await _firebaseFirestore
          .collection(groupsPath)
          .add({
        'name': groupName,
        'description': description,
        'members': members
      });

      List<String> groups = [_docRef.id];
      final String userPath = ApiPath.user(userId);
      await _firebaseFirestore.doc(userPath).update({
        'groups': FieldValue.arrayUnion(groups),
      });
    } catch (e) {
      log('Create Group Error');
      log(e.toString());
    }
  }

  Stream<List<Group>> getUserGroups(String userId) {
    final String groupsPath = ApiPath.groups;
    final CollectionReference groupsCollection =
        _firebaseFirestore.collection(groupsPath);

    return groupsCollection.snapshots().map(
      (QuerySnapshot querySnapshot) {
        return querySnapshot.docs
            .map(
              (QueryDocumentSnapshot snapshot) {
                final Map<String, dynamic> data =
                    snapshot.data() as Map<String, dynamic>;

                data['id'] = snapshot.id;

                return Group.fromJson(data);
              },
            )
            .where((group) => group.members.contains(userId))
            .toList();
      },
    );
  }
}
