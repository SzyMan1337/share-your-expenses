import 'package:flutter/material.dart';
import 'package:share_your_expenses/services/auth_service.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/shared/loading_snackbar.dart';
import 'package:share_your_expenses/utils/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();

  final AuthService _authService = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        actions: [
          Image.asset(
            "assets/images/logo.png",
            semanticLabel: 'logo',
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextFormField(
                  key: const Key('email'),
                  controller: _emailFieldController,
                  decoration: InputDecoration(
                    labelText: 'Username',
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
                  validator: Validators.validateEmail,
                ),
                CommonButton(
                  onPressed: _onSubmitLoginButton,
                  text: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isFormValidated() {
    final FormState form = formKey.currentState!;
    return form.validate();
  }

  _onSubmitLoginButton() async {
    if (_isFormValidated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        loadingSnackBar(
          text: " Wait please...",
        ),
      );

      await _authService.sendPasswordResetEmail(
        email: _emailFieldController.text,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please check your email!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.popAndPushNamed(context, '/login');
    }
  }
}
