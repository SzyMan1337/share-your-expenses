import 'package:flutter/material.dart';

loadingSnackBar({
  text = 'Loading...',
}) {
  return SnackBar(
    content: Row(
      children: <Widget>[
        const CircularProgressIndicator(),
        const SizedBox(
          width: 20,
        ),
        Text(text)
      ],
    ),
  );
}
