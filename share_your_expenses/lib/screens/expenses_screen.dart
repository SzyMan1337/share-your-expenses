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
  String groupName = '';

  @override
  void initState() {
    super.initState();
    _loadItems(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = {"0": l10n!.addToGroup, "1": l10n.cancel};

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: Text(groupName),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              switch (value) {
                case "0":
                  showAddToGroupDialog(context, widget.groupId);
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
            groupId: widget.groupId,
            expense: _expenses[index],
            animation: animation,
            currency: currency,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add-expense',
              arguments: widget.groupId);
        },
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _loadItems(String groupId) async {
    final group = await _firestoreService.getGroupAsync(groupId);
    if (mounted) {
      setState(() {
        currency = group.currency;
        groupName = group.name;
      });
    }
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
