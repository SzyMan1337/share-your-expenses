import 'package:flutter/material.dart';
import 'package:share_your_expenses/screens/forgot_password_screen.dart';
import 'package:share_your_expenses/screens/home_screen.dart';
import 'package:share_your_expenses/screens/loading_screen.dart';
import 'package:share_your_expenses/screens/login_screen.dart';
import 'package:share_your_expenses/screens/logout_screen.dart';
import 'package:share_your_expenses/screens/manage_groups_screen.dart';
import 'package:share_your_expenses/screens/register_screen.dart';

class ShareExpensesApp extends StatelessWidget {
  const ShareExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const LoadingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterSreen(),
        '/groups': (context) => const ManageGroupsScreen(),
        '/home': (context) => const HomeScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen()
      },
      theme: ThemeData(primarySwatch: Colors.blueGrey),
    );
  }
}
