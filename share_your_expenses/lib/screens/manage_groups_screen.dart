import 'package:flutter/material.dart';
import 'package:share_your_expenses/models/group.dart';
import 'package:share_your_expenses/services/auth_service.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:share_your_expenses/shared/group_item.dart';
import 'package:share_your_expenses/shared/menu_bottom.dart';

class ManageGroupsScreen extends StatefulWidget {
  const ManageGroupsScreen({Key? key}) : super(key: key);

  @override
  _ManageGroupsScreenState createState() => _ManageGroupsScreenState();
}

class _ManageGroupsScreenState extends State<ManageGroupsScreen> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final FirestoreService _firestoreService = FirestoreService.instance;
  final AuthService _authService = AuthService.instance;

  final List<Group> _groups = [];

  @override
  void initState() {
    super.initState();

    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MenuBottom(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Manage Groups"),
      ),
      body: AnimatedList(
        key: listKey,
        initialItemCount: _groups.length,
        itemBuilder: (context, index, Animation<double> animation) {
          return GroupItem(
            group: _groups[index],
            animation: animation,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add-expenses-group');
        },
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _loadItems() async {
    final List<Group> groups = await _firestoreService
        .getUserGroups(_authService.currentUser!.uid)
        .first;

    for (Group item in groups) {
      await Future.delayed(const Duration(milliseconds: 80));
      _groups.add(item);
      if (listKey.currentState != null) {
        listKey.currentState!.insertItem(_groups.length - 1);
      }
    }
  }
}
