import 'package:share_your_expenses/models/expense.dart';

class ExpenseDetailsArguments {
  final Expense expense;
  final String username;
  final String currency;

  ExpenseDetailsArguments(
    this.expense,
    this.username,
    this.currency,
  );
}
