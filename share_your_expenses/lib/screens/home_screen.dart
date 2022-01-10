import 'package:flutter/material.dart';
import 'package:share_your_expenses/shared/common_button.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final loginScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 100,
              width: 100,
            ),
            Image.asset(
              "assets/images/friends.jpg",
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            Text(
              "Share your expenses now!",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CommonButton(
                  onPressed: () {},
                  text: 'Register',
                  highlighColor: true,
                ),
                const SizedBox(
                  width: 20,
                ),
                CommonButton(
                  onPressed: () {},
                  text: 'Log In',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
