import 'package:flutter/material.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/shared/loading_snackbar.dart';
import 'package:share_your_expenses/utils/validators.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final formKey = GlobalKey<FormState>();
  final _expenseNameFieldController = TextEditingController(); 
  final _expenseDescriptionFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _expenseNameFieldController.text = 'Name';
    _expenseDescriptionFieldController.text = 'Plane tickets';
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: _expenseNameFieldController,
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
                ],
              ),
              CommonButton(
                onPressed: () {
                  _onSubmitSaveButton();
                },
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmitSaveButton() async {
    if (_isFormValidated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        loadingSnackBar(
          text: " Adding new expense...",
        ),
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      Navigator.pop(context);
    }
  }

  bool _isFormValidated() {
    final FormState form = formKey.currentState!;
    return form.validate();
  }
}
