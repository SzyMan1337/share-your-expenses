import 'package:flutter/material.dart';

class ManageGroupsScreen extends StatefulWidget {
  const ManageGroupsScreen({Key? key}) : super(key: key);

  @override
  _ManageGroupsScreenState createState() => _ManageGroupsScreenState();
}

class _ManageGroupsScreenState extends State<ManageGroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Manage Groups"),
      ),
    );
  }
}
