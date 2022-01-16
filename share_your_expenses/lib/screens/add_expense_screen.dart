import 'package:flutter/material.dart';
import 'package:share_your_expenses/services/auth_service.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/shared/loading_snackbar.dart';
import 'package:share_your_expenses/utils/validators.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({
    Key? key,
    required this.groupId,
  }) : super(key: key);
  final String groupId;
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final formKey = GlobalKey<FormState>();
  final _expenseNameFieldController = TextEditingController();
  final _expenseDescriptionFieldController = TextEditingController();
  final _expenseAmountFieldController = TextEditingController();
  final _expenseDateFieldController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService.instance;
  final AuthService _authService = AuthService.instance;

  DateTime? _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _expenseNameFieldController.text = 'Name';
    _expenseDescriptionFieldController.text = 'Plane tickets';
    _expenseAmountFieldController.text = '0.00';
    _expenseDateFieldController.text = DateFormat("yyyy-MM-dd").format(_date!);
  }

  @override
  Widget build(BuildContext context) {
    final String groupId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        centerTitle: true,
        title: const Text("New Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  TextFormField(
                    key: const Key('expenseTitle'),
                    controller: _expenseNameFieldController,
                    decoration: InputDecoration(
                      labelText: 'Expense Title',
                      hintText: 'Title',
                      labelStyle: const TextStyle(color: darkBrown),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                    ),
                    cursorColor: darkBrown,
                    validator: Validators.validateExpenseName,
                  ),
                  TextFormField(
                    key: const Key('expenseDescription'),
                    controller: _expenseDescriptionFieldController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Plane tickets',
                      labelStyle: const TextStyle(color: darkBrown),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                    ),
                    cursorColor: darkBrown,
                  ),
                  TextFormField(
                    key: const Key('amount'),
                    keyboardType: TextInputType.number,
                    controller: _expenseAmountFieldController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      hintText: 'Input amount',
                      labelStyle: const TextStyle(color: darkBrown),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                    ),
                    cursorColor: darkBrown,
                    validator: Validators.validateExpenseAmount,
                  ),
                  TextFormField(
                    key: const Key('date'),
                    keyboardType: TextInputType.datetime,
                    controller: _expenseDateFieldController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      hintText: 'Select date',
                      labelStyle: const TextStyle(color: darkBrown),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: darkBrown),
                      ),
                    ),
                    validator: Validators.validateExpenseDate,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());

                      _date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      _expenseDateFieldController.text = (_date == null
                          ? 'Select date'
                          : DateFormat("yyyy-MM-dd").format(_date!));
                    },
                    cursorColor: darkBrown,
                  ),
                ],
              ),
              CommonButton(
                onPressed: () {
                  _onSubmitSaveButton(groupId);
                },
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmitSaveButton(String groupId) async {
    if (_isFormValidated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        loadingSnackBar(
          text: " Adding new expense...",
        ),
      );

      await _firestoreService.createExpense(
        _expenseNameFieldController.text,
        _expenseDescriptionFieldController.text,
        _date!,
        double.tryParse(_expenseAmountFieldController.text)!,
        _authService.currentUser!.uid,
        groupId,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      int count = 0;
      Navigator.pushNamedAndRemoveUntil(
          context, '/group/expenses', (_) => count++ >= 2,
          arguments: groupId);
    }
  }

  bool _isFormValidated() {
    final FormState form = formKey.currentState!;
    return form.validate();
  }
}
