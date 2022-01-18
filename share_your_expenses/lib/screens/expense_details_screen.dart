import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_your_expenses/models/expense_details_arguments.dart';
import 'package:share_your_expenses/screens/image_full_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_your_expenses/shared/const.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  const ExpenseDetailsScreen({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final ExpenseDetailsArguments expense;

  @override
  _ExpenseDetailsScreenState createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          centerTitle: true,
          title: Text(widget.expense.expense.name),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 15,
                ),
                if (widget.expense.expense.photo.isNotEmpty)
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageFullScreen(
                              photo: widget.expense.expense.photo,
                              expenseTitle: widget.expense.expense.name,
                            ),
                          ),
                        );
                      },
                      child: Image.network(
                        widget.expense.expense.photo,
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                if (widget.expense.expense.photo.isEmpty)
                  const Center(
                    child: Text("No photo"),
                  ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    l10n!.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: darkBrown,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.expense.expense.description,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.amount + ": ",
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkBrown,
                        ),
                      ),
                      Text(
                        widget.expense.expense.amount.toStringAsFixed(2) +
                            " " +
                            widget.expense.currency,
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.username + ": ",
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkBrown,
                        ),
                      ),
                      Text(
                        widget.expense.username,
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.date + ": ",
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkBrown,
                        ),
                      ),
                      Text(
                        DateFormat("yyyy-MM-dd")
                            .format(widget.expense.expense.date),
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
