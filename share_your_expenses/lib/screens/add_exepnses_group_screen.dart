import 'package:flutter/material.dart';

class AddExepensesGroupScreen extends StatefulWidget {
  const AddExepensesGroupScreen({Key? key}) : super(key: key);

  @override
  _AddExepensesGroupScreenState createState() =>
      _AddExepensesGroupScreenState();
}

class _AddExepensesGroupScreenState extends State<AddExepensesGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        centerTitle: true,
        title: const Text("New Expenses Group"),
      ),
    );
  }
}
