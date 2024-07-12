import 'package:flutter/material.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'homeScreen';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final loginScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n!.welcome),
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/images/friends.jpg",
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(
              l10n.shareYourExpenses,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CommonButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/register',
                    );
                  },
                  text: l10n.register,
                  highlighColor: true,
                ),
                const SizedBox(
                  width: 20,
                ),
                CommonButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/login',
                    );
                  },
                  text: l10n.login,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
