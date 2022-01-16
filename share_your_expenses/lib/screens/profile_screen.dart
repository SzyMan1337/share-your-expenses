import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_your_expenses/services/auth_service.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/menu_bottom.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authService.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Profile"),
              ),
              bottomNavigationBar: const MenuBottom(
                selected: 1,
              ),
              body: const Center(
                child: Text('Error!'),
              ));
        }
        final User? user = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Profile"),
          ),
          bottomNavigationBar: const MenuBottom(
            selected: 1,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/login.jpg",
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
              ),
              if (user != null && user.isAnonymous)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text('You are logged in annonymously!'),
                ),
              if (user != null && !user.isAnonymous)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text('Email: ${user.email}'),
                ),
              if (user != null && !user.emailVerified && !user.isAnonymous)
                CommonButton(
                  text: 'Verify Your Email',
                  onPressed: () {
                    user.sendEmailVerification();
                  },
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CommonButton(
                  onPressed: () async {
                    await _authService.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  },
                  text: 'Logout',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
