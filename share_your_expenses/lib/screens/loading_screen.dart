import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share_your_expenses/services/auth_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final AuthService _authService = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: const SpinKitFadingCircle(
        color: Colors.white,
        size: 70.0,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        if (_authService.currentUser != null) {
          Navigator.popAndPushNamed(
            context,
            '/groups',
          );
        } else {
          Navigator.popAndPushNamed(
            context,
            '/home',
          );
        }
      },
    );
  }
}
