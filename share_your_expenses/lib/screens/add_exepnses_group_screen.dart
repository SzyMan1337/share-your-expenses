import 'package:flutter/material.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/shared/loading_snackbar.dart';
import 'package:share_your_expenses/utils/validators.dart';

class AddExepensesGroupScreen extends StatefulWidget {
  const AddExepensesGroupScreen({Key? key}) : super(key: key);

  @override
  _AddExepensesGroupScreenState createState() =>
      _AddExepensesGroupScreenState();
}

class _AddExepensesGroupScreenState extends State<AddExepensesGroupScreen> {
  final formKey = GlobalKey<FormState>();
  final _groupNameFieldController = TextEditingController();
  final _groupDescriptionFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _groupNameFieldController.text = 'Group name';
    _groupDescriptionFieldController.text = 'Trip to Warsaw';
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
        title: const Text("New Expenses Group"),
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
                    key: const Key('groutpTitle'),
                    controller: _groupNameFieldController,
                    decoration: InputDecoration(
                      labelText: 'Group Title',
                      hintText: 'Group name',
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
                    validator: Validators.validateGroupName,
                  ),
                  TextFormField(
                    key: const Key('groupDescription'),
                    controller: _groupNameFieldController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Trip to Warsaw',
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
          text: " Adding group...",
        ),
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/groups',
        (route) => false,
      );
    }
  }

  bool _isFormValidated() {
    final FormState form = formKey.currentState!;
    return form.validate();
  }
}
