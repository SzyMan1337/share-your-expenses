import 'package:flutter/material.dart';
import 'package:share_your_expenses/screens/home_screen.dart';

void main() {
  runApp(const ShareExpenseApp());
}

class ShareExpenseApp extends StatelessWidget {
  const ShareExpenseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      routes: {
        '/': (context) => const HomeScreen(),
      },
      initialRoute: '/',
    );
  }
}
