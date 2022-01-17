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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String groupId = ModalRoute.of(context)!.settings.arguments as String;
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
                case 'Add to group':
                  showAddToGroupDialog(context, groupId);
                  break;
                case 'Cancel':
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Add to group', 'Cancel'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
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
    //currency = await _firestoreService.getGroupCurrency(groupId);

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
