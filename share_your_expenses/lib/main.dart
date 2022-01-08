import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:share_your_expenses/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
