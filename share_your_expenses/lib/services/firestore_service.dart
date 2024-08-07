import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_your_expenses/enums/category.dart';
import 'package:share_your_expenses/enums/role.dart';
import 'package:share_your_expenses/models/expense.dart';
import 'package:share_your_expenses/models/firestore_user.dart';
import 'package:share_your_expenses/models/group.dart';

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
          'id': userId,
          'roles': roles.map((role) => role.name).toList(),
          'userName': userName,
          'groups': List<String>.empty(),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      log('Create User Error');
    }
  }

  Future<FirestoreUser> getUser(String userId) async {
    final String path = ApiPath.user(userId);
    final DocumentSnapshot document = await _firebaseFirestore.doc(path).get();
    final Map<String, dynamic> json = document.data() as Map<String, dynamic>;

    return FirestoreUser.fromJson(json);
  }

  Future<FirestoreUser?> getUserByUsername(String username) async {
    final List<FirestoreUser> users = await getUsers();
    final result = users.where((element) => element.userName == username);
    return result.isEmpty ? null : result.first;
  }

  Future<void> createGroup(String groupName, String description, String userId,
      String currency, GroupCategory category) async {
    try {
      List<String> members = [userId];
      final String groupsPath = ApiPath.groups;

      Group group = Group(
        category: category,
        name: groupName,
        description: description,
        members: members,
        currency: currency,
      );

      DocumentReference docRef =
          await _firebaseFirestore.collection(groupsPath).add(group.toJson());

      List<String> groups = [docRef.id];
      final String userPath = ApiPath.user(userId);
      await _firebaseFirestore.doc(userPath).update({
        'groups': FieldValue.arrayUnion(groups),
      });
    } catch (e) {
      log('Create Group Error');
      log(e.toString());
    }
  }

  Future<void> createExpense(
      String expensName,
      String description,
      DateTime date,
      double amount,
      String userId,
      String groupId,
      String fileNameRef) async {
    try {
      final String expensePath = ApiPath.groupExpenses(groupId);

      await _firebaseFirestore.collection(expensePath).add({
        'name': expensName,
        'description': description,
        'amount': amount,
        'userId': userId,
        'date': date,
        'photo': fileNameRef,
      });
    } catch (e) {
      log('Create Expense Error');
      log(e.toString());
    }
  }

  Future<void> addUserToGroup(String groupId, String userId) async {
    try {
      final String userPath = ApiPath.user(userId);
      final List<String> groupsToAdd = [groupId];
      await _firebaseFirestore.doc(userPath).update({
        'groups': FieldValue.arrayUnion(groupsToAdd),
      });

      final String groupPath = ApiPath.group(groupId);
      final List<String> usersToAdd = [userId];
      await _firebaseFirestore.doc(groupPath).update({
        'members': FieldValue.arrayUnion(usersToAdd),
      });
    } catch (e) {
      log('Adding user to group error');
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

  Future<List<FirestoreUser>> getUsers() async {
    final String path = ApiPath.users;
    final collectionReference = await _firebaseFirestore.collection(path).get();

    if (collectionReference.docs.isEmpty) return [];

    return collectionReference.docs
        .map((doc) => FirestoreUser.fromJson(doc.data()))
        .toList();
  }

  Future<bool> checkIfUsernameAvailable(String username) async {
    final List<FirestoreUser> users = await getUsers();
    return !users.any((element) => element.userName == username);
  }

  Stream<Group> getGroup(String id) {
    final String path = ApiPath.group(id);
    final Stream<DocumentSnapshot> snapshots =
        _firebaseFirestore.doc(path).snapshots();

    return snapshots.map(
      (DocumentSnapshot snapshot) {
        final Map<String, dynamic> data =
            snapshot.data() as Map<String, dynamic>;

        data['id'] = snapshot.id;

        return Group.fromJson(data);
      },
    );
  }

  Stream<List<Expense>> getGroupExpenses(String groupId) {
    final String expensesPath = ApiPath.groupExpenses(groupId);
    final CollectionReference expensesCollection =
        _firebaseFirestore.collection(expensesPath);

    return expensesCollection.snapshots().map(
      (QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map(
          (QueryDocumentSnapshot snapshot) {
            if (snapshot.data() != null) {}
            final Map<String, dynamic> data =
                snapshot.data() as Map<String, dynamic>;

            data['id'] = snapshot.id;
            return Expense.fromJson(data);
          },
        ).toList();
      },
    );
  }

  Stream<Expense> getExpense(String groupId, String expenseId) {
    final String path = ApiPath.groupExpense(groupId, expenseId);
    final Stream<DocumentSnapshot> snapshots =
        _firebaseFirestore.doc(path).snapshots();

    return snapshots.map(
      (DocumentSnapshot snapshot) {
        final Map<String, dynamic> data =
            snapshot.data() as Map<String, dynamic>;
        data['id'] = snapshot.id;

        return Expense.fromJson(data);
      },
    );
  }

  Stream<FirestoreUser> getUserStream(String userId) {
    final String path = ApiPath.user(userId);
    final Stream<DocumentSnapshot> snapshots =
        _firebaseFirestore.doc(path).snapshots();

    return snapshots.map(
      (DocumentSnapshot snapshot) {
        final Map<String, dynamic> data =
            snapshot.data() as Map<String, dynamic>;
        return FirestoreUser.fromJson(data);
      },
    );
  }

  Future<Group> getGroupAsync(String groupId) async {
    final String path = ApiPath.group(groupId);
    final DocumentSnapshot document = await _firebaseFirestore.doc(path).get();
    final Map<String, dynamic> json = document.data() as Map<String, dynamic>;

    return Group.fromJson(json);
  }
}
