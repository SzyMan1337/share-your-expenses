import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_your_expenses/enums/role.dart';
import 'package:share_your_expenses/services/auth_service.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:share_your_expenses/shared/alert_dialog.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/shared/loading_snackbar.dart';
import 'package:share_your_expenses/shared/login_inputs.dart';
import 'package:share_your_expenses/utils/validators.dart';

class RegisterSreen extends StatefulWidget {
  const RegisterSreen({Key? key}) : super(key: key);

  @override
  _RegisterSreenState createState() => _RegisterSreenState();
}

class _RegisterSreenState extends State<RegisterSreen> {
  final formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _usernameFieldController = TextEditingController();

  final AuthService _authService = AuthService.instance;
  final FirestoreService _firestoreService = FirestoreService.instance;

  @override
  void initState() {
    super.initState();
    _emailFieldController.text = 'example@email.com';
    _passwordFieldController.text = 'password';
    _usernameFieldController.text = 'Bob123';
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text("Register"),
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
              TextFormField(
                key: const Key('username'),
                controller: _usernameFieldController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Bob123',
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
              LoginInputs(
                emailFieldController: _emailFieldController,
                passwordFieldController: _passwordFieldController,
              ),
              CommonButton(
                onPressed: () {
                  _onSubmitRegisterButton(context);
                },
                text: 'Register',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Have an account? ",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/login',
                      );
                    },
                    child: const Text(
                      " Sign In",
                      style: TextStyle(
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

  _onSubmitRegisterButton(context) async {
    if (_isFormValidated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        loadingSnackBar(
          text: " Creating user...",
        ),
      );

      var isAvailable = await _firestoreService
          .checkIfUsernameAvailable(_usernameFieldController.text);
      if (!isAvailable) {
        showAlertDialog(
            'The account already exists for that username.', context);
      }

      final User? user = await _authService.createUserWithEmailAndPassword(
          email: _emailFieldController.text,
          password: _passwordFieldController.text,
          context: context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (user != null) {
        await _firestoreService.createUser(
            user.uid, [UserRole.customer], _usernameFieldController.text);

        Navigator.pushNamedAndRemoveUntil(context, '/groups', (route) => false);
      }
    }
  }
}
