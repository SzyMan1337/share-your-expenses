import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: const Text("Flat Expenses"),
        // bottom: const PreferredSize(
        //     preferredSize: Size.fromHeight(1),
        //     child: Text("Mateusz, Ola, Jacek")),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              "assets/images/logo.png",
              semanticLabel: 'logo',
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
