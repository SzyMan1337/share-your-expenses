import 'package:flutter/material.dart';
import 'package:share_your_expenses/models/firestore_user.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:share_your_expenses/shared/alert_dialog.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/shared/loading_snackbar.dart';
import 'package:share_your_expenses/utils/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showAddToGroupDialog(BuildContext context, String groupId) async {
  final _usernameToAddFieldController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService.instance;
  final formKey = GlobalKey<FormState>();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final l10n = AppLocalizations.of(context);
      final validators = Validators(l10n!);
      return AlertDialog(
        scrollable: true,
        title: Text(l10n.addNewUserToGroup),
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
                        labelText: l10n.username,
                        hintText: l10n.username,
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
                      validator: validators.validateUserName,
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
                      text: l10n.addingUser,
                    ),
                  );

                  FirestoreUser? user = await _firestoreService
                      .getUserByUsername(_usernameToAddFieldController.text);

                  if (user == null) {
                    showAlertDialog(l10n.userDoesNotExistsUsername, context);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    return;
                  } else {
                    await _firestoreService.addUserToGroup(
                      groupId,
                      user.id,
                    );
                  }
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Navigator.pop(context);
                }
              },
              text: l10n.add,
            ),
          ),
        ],
      );
    },
  );
}
