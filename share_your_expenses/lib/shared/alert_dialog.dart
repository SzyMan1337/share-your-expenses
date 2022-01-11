import 'package:flutter/material.dart';

Future<void> showAlertDialog(String message, BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error!'),
        content: Text(message),
      );
    },
  );
}
