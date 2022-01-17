import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showAlertDialog(String message, BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final l10n = AppLocalizations.of(context);
      return AlertDialog(
        title: Text(l10n!.information),
        content: Text(message),
      );
    },
  );
}
