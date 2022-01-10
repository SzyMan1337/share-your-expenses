import 'package:flutter/material.dart';
import 'package:share_your_expenses/screens/loading_screen.dart';

class ShareExpensesApp extends StatelessWidget {
  const ShareExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: const LoadingScreen());
  }
}
