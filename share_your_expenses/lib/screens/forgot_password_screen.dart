import 'package:flutter/material.dart';
import 'package:share_your_expenses/services/auth_service.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/shared/loading_snackbar.dart';
import 'package:share_your_expenses/utils/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();

  final AuthService _authService = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final validators = Validators(l10n!);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n.forgotPassword),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Center(
                child: Image.asset(
                  "assets/images/login.jpg",
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
              TextFormField(
                key: const Key('email'),
                controller: _emailFieldController,
                decoration: InputDecoration(
                  labelText: l10n.username,
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
              CommonButton(
                onPressed: () {
                  _onSubmitLoginButton(l10n);
                },
                text: l10n.submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isFormValidated() {
    if (formKey.currentState == null) return false;
    final FormState form = formKey.currentState!;
    return form.validate();
  }

  _onSubmitLoginButton(AppLocalizations l10n) async {
    if (_isFormValidated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        loadingSnackBar(
          text: l10n.waitPlease,
        ),
      );

      await _authService.sendPasswordResetEmail(
        email: _emailFieldController.text,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(l10n.checkYourEmail),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.popAndPushNamed(context, '/login');
    }
  }
}
