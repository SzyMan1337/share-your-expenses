import 'package:flutter/material.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  const ExpenseDetailsScreen({Key? key}) : super(key: key);

  @override
  _ExpenseDetailsScreenState createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: const Text("Expense Detail"),
      ),
    );
  }
}
