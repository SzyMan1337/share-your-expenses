import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_your_expenses/models/firestore_user.dart';
import 'package:share_your_expenses/services/auth_service.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/menu_bottom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService.instance;
  final FirestoreService _firestoreService = FirestoreService.instance;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
                title: Text(l10n!.profile),
              ),
              bottomNavigationBar: const MenuBottom(
                selected: 1,
              ),
              body: Center(
                child: Text(l10n.error),
              ));
        }
        final User? user = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(l10n!.profile),
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
              StreamBuilder<FirestoreUser?>(
                  stream: _firestoreService
                      .getUserStream(_authService.currentUser!.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<FirestoreUser?> snapshotFire) {
                    final FirestoreUser? firestoreUser = snapshotFire.data;
                    if (firestoreUser != null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child:
                            Text('${l10n.username}: ${firestoreUser.userName}'),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text('${l10n.username}: ---'),
                    );
                  }),
              if (user != null && !user.isAnonymous)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text('Email: ${user.email}'),
                ),
              if (user != null && !user.emailVerified && !user.isAnonymous)
                CommonButton(
                  text: l10n.verifyEmail,
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
                  text: l10n.logout,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
