import 'package:flutter/material.dart';
import 'package:share_your_expenses/models/user.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:share_your_expenses/shared/alert_dialog.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/shared/loading_snackbar.dart';
import 'package:share_your_expenses/utils/validators.dart';

Future<void> showAddToGroupDialog(BuildContext context, String groupId) async {
  final _usernameToAddFieldController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService.instance;
  final formKey = GlobalKey<FormState>();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        title: const Text("Add new user to group"),
        content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: const Key('usernameToAdd'),
                      controller: _usernameToAddFieldController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Username',
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
                      validator: Validators.validateUserName,
                    ),
                  ],
                ))),
        actions: [
          Center(
            child: CommonButton(
              onPressed: () async {
                final FormState form = formKey.currentState!;
                if (form.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    loadingSnackBar(
                      text: " Adding user...",
                    ),
                  );

                  User? user = await _firestoreService
                      .getUserByUsername(_usernameToAddFieldController.text);

                  if (user == null) {
                    showAlertDialog('The given user does not exist', context);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    return;
                  } else {
                    await _firestoreService.addUserToGroup(
                      groupId,
                      user.id!,
                    );
                  }
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Navigator.pop(context);
                }
              },
              text: 'Add',
            ),
          ),
        ],
      );
    },
  );
}
