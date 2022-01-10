import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:share_your_expenses/share_expenses_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const ShareExpensesApp());
}
