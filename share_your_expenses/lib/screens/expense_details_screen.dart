import 'package:flutter/material.dart';
import 'package:share_your_expenses/models/expense_details_arguments.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  const ExpenseDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ExpenseDetailsScreenState createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  late ExpenseDetailsArguments arguments;

  @override
  Widget build(BuildContext context) {
    arguments =
        ModalRoute.of(context)!.settings.arguments as ExpenseDetailsArguments;
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          centerTitle: true,
          title: const Text("Expense Detail"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
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
              
            ],
          ),
        ));
  }
}
