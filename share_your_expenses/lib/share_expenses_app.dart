import 'package:flutter/material.dart';
import 'package:share_your_expenses/screens/add_exepnses_group_screen.dart';
import 'package:share_your_expenses/screens/add_expense_screen.dart';
import 'package:share_your_expenses/screens/expenses_screen.dart';
import 'package:share_your_expenses/screens/forgot_password_screen.dart';
import 'package:share_your_expenses/screens/home_screen.dart';
import 'package:share_your_expenses/screens/loading_screen.dart';
import 'package:share_your_expenses/screens/login_screen.dart';
import 'package:share_your_expenses/screens/manage_groups_screen.dart';
import 'package:share_your_expenses/screens/profile_screen.dart';
import 'package:share_your_expenses/screens/register_screen.dart';

class ShareExpensesApp extends StatelessWidget {
  const ShareExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => const LoadingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterSreen(),
        '/groups': (context) => const ManageGroupsScreen(),
        '/home': (context) => const HomeScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/add-expenses-group': (context) => const AddExepensesGroupScreen(),
        '/add-expense': (context) => const AddExpenseScreen(
              groupId: '',
            ),
        '/profile': (context) => const ProfileScreen(),
        '/group/expenses': (context) => const ExpensesScreen(
              groupId: '',
            ),
      },
      theme: ThemeData(primarySwatch: Colors.blueGrey),
    );
  }
}
