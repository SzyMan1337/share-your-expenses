import 'package:flutter/material.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/menu_bottom.dart';

class ManageGroupsScreen extends StatefulWidget {
  const ManageGroupsScreen({Key? key}) : super(key: key);

  @override
  _ManageGroupsScreenState createState() => _ManageGroupsScreenState();
}

class _ManageGroupsScreenState extends State<ManageGroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MenuBottom(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Manage Groups"),
      ),
      body: CommonButton(
        text: 'dupa',
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add-expenses-group');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
