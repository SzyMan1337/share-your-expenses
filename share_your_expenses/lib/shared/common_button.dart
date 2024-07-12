import 'package:flutter/material.dart';

import 'const.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    this.onPressed,
    this.highlighColor = false,
    required this.text,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool highlighColor;

  Color get backgroundColor {
    return highlighColor ? darkBrown : Colors.white;
  }

  Color get textColor {
    return highlighColor ? Colors.white : darkBrown;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: key,
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          backgroundColor,
        ),
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(color: darkBrown),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.fromLTRB(55, 15, 55, 15),
        ),
        shape: WidgetStateProperty.all(
          const StadiumBorder(),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
