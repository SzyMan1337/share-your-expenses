import 'package:flutter/material.dart';
import 'package:share_your_expenses/models/expense.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem({
    Key? key,
    required this.animation,
    required this.expense,
    required this.groupId,
  }) : super(key: key);

  final FirestoreService _firestoreService = FirestoreService.instance;

  final Expense expense;
  final String groupId;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Expense>(
      stream: _firestoreService.getExpense(groupId, expense.id!),
      builder: (context, AsyncSnapshot<Expense> snapshot) {
        Expense newExpense = expense;

        if (snapshot.hasData) {
          newExpense = snapshot.data!;
        }

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: animation,
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
                    newExpense.amount.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text(
                    'Paid by me',
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
              //Navigator.pushNamed(context, '/expense', arguments: expense.id);
            },
          ),
        );
      },
    );
  }
}
