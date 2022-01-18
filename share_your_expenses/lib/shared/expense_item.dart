import 'package:flutter/material.dart';
import 'package:share_your_expenses/models/expense.dart';
import 'package:share_your_expenses/models/expense_details_arguments.dart';
import 'package:share_your_expenses/screens/expense_details_screen.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpenseItem extends StatefulWidget {
  const ExpenseItem({
    Key? key,
    required this.animation,
    required this.expense,
    required this.groupId,
    required this.currency,
  }) : super(key: key);

  final Expense expense;
  final String groupId;
  final String currency;
  final Animation<double> animation;

  @override
  State<ExpenseItem> createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  final FirestoreService _firestoreService = FirestoreService.instance;

  String userName = '';

  @override
  void initState() {
    _loadUSername(widget.expense.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return StreamBuilder<Expense>(
      stream: _firestoreService.getExpense(widget.groupId, widget.expense.id!),
      builder: (context, AsyncSnapshot<Expense> snapshot) {
        Expense newExpense = widget.expense;
        if (snapshot.hasData) {
          newExpense = snapshot.data!;
        }

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: widget.animation,
              curve: Curves.bounceIn,
              reverseCurve: Curves.bounceOut,
            ),
          ),
          child: GestureDetector(
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              title: Row(
                children: [
                  Text(
                    newExpense.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Spacer(),
                  Text(
                    newExpense.amount.toStringAsFixed(2) +
                        " " +
                        widget.currency,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text(
                    l10n!.paidBy + userName,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const Spacer(),
                  Text(
                    DateFormat("yyyy-MM-dd").format(newExpense.date),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpenseDetailsScreen(
                    expense: ExpenseDetailsArguments(
                      widget.expense,
                      userName,
                      widget.currency,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _loadUSername(String userId) async {
    final name = (await _firestoreService.getUser(userId)).userName;
    if (mounted) {
      setState(() {
        userName = name;
      });
    }
  }
}
