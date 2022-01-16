import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:share_your_expenses/enums/category.dart';
import 'package:share_your_expenses/services/auth_service.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/shared/loading_snackbar.dart';
import 'package:share_your_expenses/utils/validators.dart';

class AddExepensesGroupScreen extends StatefulWidget {
  const AddExepensesGroupScreen({Key? key}) : super(key: key);

  @override
  _AddExepensesGroupScreenState createState() =>
      _AddExepensesGroupScreenState();
}

class _AddExepensesGroupScreenState extends State<AddExepensesGroupScreen> {
  final formKey = GlobalKey<FormState>();
  final _groupNameFieldController = TextEditingController();
  final _groupDescriptionFieldController = TextEditingController();
  final _groupCurrencyFieldController = TextEditingController();
  GroupCategory _category = GroupCategory.couple;

  final FirestoreService _firestoreService = FirestoreService.instance;
  final AuthService _authService = AuthService.instance;

  Currency? _currency;

  @override
  void initState() {
    super.initState();
    _groupNameFieldController.text = 'Group name';
    _groupDescriptionFieldController.text = 'Trip to Warsaw';
    _groupCurrencyFieldController.text = 'PLN';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text("New Expenses Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  TextFormField(
                    key: const Key('groutpTitle'),
                    controller: _groupNameFieldController,
                    decoration: InputDecoration(
                      labelText: 'Group Title',
                      hintText: 'Group name',
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
                    validator: Validators.validateGroupName,
                  ),
                  TextFormField(
                    key: const Key('groupDescription'),
                    controller: _groupDescriptionFieldController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Trip to Warsaw',
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
                  ),
                  TextFormField(
                    key: const Key('currency'),
                    keyboardType: TextInputType.datetime,
                    controller: _groupCurrencyFieldController,
                    decoration: InputDecoration(
                      labelText: 'Currency',
                      hintText: 'Select currency',
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
                    validator: Validators.validateGroupCurrency,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());

                      showCurrencyPicker(
                        context: context,
                        showFlag: true,
                        showCurrencyName: true,
                        showCurrencyCode: true,
                        onSelect: (Currency currency) {
                          _currency = currency;
                          setState(() {
                            _groupCurrencyFieldController.text =
                                (_currency == null
                                    ? 'Select currency'
                                    : _currency!.code);
                          });
                        },
                        favorite: ['PLN', 'USD', 'EUR'],
                      );
                    },
                    cursorColor: darkBrown,
                  ),
                  const SizedBox(height: 15),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 12,
                        color: darkBrown,
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          GroupCategory.couple.iconData,
                          size: 40,
                          color: getColor(_category == GroupCategory.couple),
                        ),
                        onPressed: () {
                          _category = GroupCategory.couple;
                          setState(() {});
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          GroupCategory.sharedHouse.iconData,
                          size: 40,
                          color:
                              getColor(_category == GroupCategory.sharedHouse),
                        ),
                        onPressed: () {
                          _category = GroupCategory.sharedHouse;
                          setState(() {});
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          GroupCategory.event.iconData,
                          size: 40,
                          color: getColor(_category == GroupCategory.event),
                        ),
                        onPressed: () {
                          _category = GroupCategory.event;
                          setState(() {});
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          GroupCategory.other.iconData,
                          size: 40,
                          color: getColor(_category == GroupCategory.other),
                        ),
                        onPressed: () {
                          _category = GroupCategory.other;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
              CommonButton(
                onPressed: () {
                  _onSubmitSaveButton();
                },
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmitSaveButton() async {
    if (_isFormValidated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        loadingSnackBar(
          text: " Adding group...",
        ),
      );

      await _firestoreService.createGroup(
          _groupNameFieldController.text,
          _groupDescriptionFieldController.text,
          _authService.currentUser!.uid,
          _groupCurrencyFieldController.text,
          _category);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/groups',
        (route) => false,
      );
    }
  }

  bool _isFormValidated() {
    final FormState form = formKey.currentState!;
    return form.validate();
  }

  getColor(bool isSelected) {
    return isSelected ? Colors.brown.shade800 : Colors.grey.shade400;
  }
}
