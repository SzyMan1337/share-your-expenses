import 'package:flutter/material.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/utils/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginInputs extends StatelessWidget {
  const LoginInputs({
    super.key,
    required this.emailFieldController,
    required this.passwordFieldController,
  });

  final TextEditingController emailFieldController;
  final TextEditingController passwordFieldController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final validators = Validators(l10n!);
    return Column(
      children: <Widget>[
        TextFormField(
          key: const Key('email'),
          controller: emailFieldController,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'example@email.com',
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
          validator: validators.validateEmail,
        ),
        const SizedBox(height: 20),
        TextFormField(
          key: const Key('password'),
          controller: passwordFieldController,
          autocorrect: false,
          obscureText: true,
          decoration: InputDecoration(
            hintText: l10n.securepassword,
            labelText: l10n.password,
            labelStyle: const TextStyle(color: darkBrown),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: darkBrown),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: darkBrown),
            ),
          ),
          cursorColor: darkBrown,
          validator: validators.validatePassword,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
