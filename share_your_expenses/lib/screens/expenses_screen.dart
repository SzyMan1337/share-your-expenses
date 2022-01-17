import 'package:flutter/material.dart';
import 'package:share_your_expenses/models/expense.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:share_your_expenses/shared/add_to_group_dialog.dart';
import 'package:share_your_expenses/shared/expense_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  final String groupId;
  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final FirestoreService _firestoreService = FirestoreService.instance;
  final List<Expense> _expenses = [];
  String currency = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String groupId = ModalRoute.of(context)!.settings.arguments as String;
    final options = {"0": l10n!.addToGroup, "1": l10n.cancel};
    _loadItems(groupId);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: const Text("Flat Expenses"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              switch (value) {
                case "0":
                  showAddToGroupDialog(context, groupId);
                  break;
                case "1":
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return options.keys.map((key) {
                return PopupMenuItem<String>(
                  value: key,
                  child: Text(options[key]!),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: AnimatedList(
        key: listKey,
        initialItemCount: _expenses.length,
        itemBuilder: (context, index, Animation<double> animation) {
          return ExpenseItem(
            groupId: groupId,
            expense: _expenses[index],
            animation: animation,
            currency: currency,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add-expense', arguments: groupId);
        },
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _loadItems(String groupId) async {
    currency = await _firestoreService.getGroupCurrency(groupId) ?? "";
    final List<Expense> expenses =
        await _firestoreService.getGroupExpenses(groupId).first;

    for (Expense item in expenses) {
      await Future.delayed(const Duration(milliseconds: 80));
      _expenses.add(item);
      if (listKey.currentState != null) {
        listKey.currentState!.insertItem(_expenses.length - 1);
      }
    }
  }
}
