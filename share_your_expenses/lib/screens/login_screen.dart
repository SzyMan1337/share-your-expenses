import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_your_expenses/services/auth_service.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/shared/loading_snackbar.dart';
import 'package:share_your_expenses/shared/login_inputs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final AuthService _authService = AuthService.instance;

  @override
  void initState() {
    super.initState();
    _emailFieldController.text = 'example@email.com';
    _passwordFieldController.text = 'password';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: Text(l10n!.login),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              "assets/images/logo.png",
              semanticLabel: 'logo',
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
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
              LoginInputs(
                emailFieldController: _emailFieldController,
                passwordFieldController: _passwordFieldController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/forgot-password',
                      );
                    },
                    child: Text(
                      l10n.forgotPassword,
                      style: const TextStyle(
                        color: darkBrown,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              CommonButton(
                onPressed: () {
                  _onSubmitLoginButton(l10n);
                },
                text: l10n.login,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    l10n.noAccountQuestion,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/register',
                      );
                    },
                    child: Text(
                      l10n.register,
                      style: const TextStyle(
                        color: darkBrown,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isFormValidated() {
    final FormState form = formKey.currentState!;
    return form.validate();
  }

  _onSubmitLoginButton(AppLocalizations l10n) async {
    if (_isFormValidated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        loadingSnackBar(
          text: l10n.signingIn,
        ),
      );

      final User? user = await _authService.signInWithEmailAndPassword(
        email: _emailFieldController.text,
        password: _passwordFieldController.text,
        context: context,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/groups',
          (route) => false,
        );
      }
    }
  }
}
