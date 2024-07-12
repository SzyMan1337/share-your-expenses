import 'package:flutter/material.dart';
import 'package:share_your_expenses/models/group.dart';
import 'package:share_your_expenses/services/auth_service.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:share_your_expenses/shared/group_item.dart';
import 'package:share_your_expenses/shared/menu_bottom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ManageGroupsScreen extends StatefulWidget {
  const ManageGroupsScreen({super.key});

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
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      bottomNavigationBar: const MenuBottom(
        selected: 0,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n!.manageGroups),
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
