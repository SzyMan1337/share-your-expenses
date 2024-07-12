import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_your_expenses/screens/expenses_screen.dart';
import 'package:share_your_expenses/services/auth_service.dart';
import 'package:share_your_expenses/services/firestore_service.dart';
import 'package:share_your_expenses/services/storage_service.dart';
import 'package:share_your_expenses/shared/common_button.dart';
import 'package:share_your_expenses/shared/const.dart';
import 'package:share_your_expenses/shared/loading_snackbar.dart';
import 'package:share_your_expenses/utils/validators.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({
    super.key,
    required this.groupId,
  });
  final String groupId;
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final formKey = GlobalKey<FormState>();
  final _expenseNameFieldController = TextEditingController();
  final _expenseDescriptionFieldController = TextEditingController();
  final _expenseAmountFieldController = TextEditingController();
  final _expenseDateFieldController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService.instance;
  final StorageService _storageService = StorageService.instance;
  final AuthService _authService = AuthService.instance;

  XFile? image;
  DateTime? _date = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final validators = Validators(l10n!);

    final String groupId = ModalRoute.of(context)!.settings.arguments as String;
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
        title: Text(l10n.newExpense),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    if (image != null)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Image.file(
                            File(image!.path),
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    if (image == null)
                      const SizedBox(
                          height: 50,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text(
                                "No photo atatched",
                                style: TextStyle(color: darkBrown),
                              ),
                            ),
                          )),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 20,
                            child: IconButton(
                              icon: const Icon(
                                Icons.attach_file,
                                size: 20,
                              ),
                              onPressed: () {
                                _atachFileButtonPressed();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 20,
                              ),
                              onPressed: () {
                                _cameraButtonPressed();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      key: const Key('expenseTitle'),
                      controller: _expenseNameFieldController,
                      decoration: InputDecoration(
                        labelText: l10n.expenseTitle,
                        hintText: l10n.title,
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
                      validator: validators.validateExpenseName,
                    ),
                    TextFormField(
                      key: const Key('expenseDescription'),
                      controller: _expenseDescriptionFieldController,
                      decoration: InputDecoration(
                        labelText: l10n.description,
                        hintText: l10n.planeTickets,
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
                      key: const Key('amount'),
                      keyboardType: TextInputType.number,
                      controller: _expenseAmountFieldController,
                      decoration: InputDecoration(
                        labelText: l10n.amount,
                        hintText: l10n.inputAmount,
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
                      validator: validators.validateExpenseAmount,
                    ),
                    TextFormField(
                      key: const Key('date'),
                      keyboardType: TextInputType.datetime,
                      controller: _expenseDateFieldController,
                      decoration: InputDecoration(
                        labelText: l10n.date,
                        hintText: l10n.selectDate,
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
                      validator: validators.validateExpenseDate,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        _date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );

                        _expenseDateFieldController.text = (_date == null
                            ? l10n.selectDate
                            : DateFormat("yyyy-MM-dd").format(_date!));
                      },
                      cursorColor: darkBrown,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CommonButton(
                  onPressed: () {
                    _onSubmitSaveButton(groupId, l10n);
                  },
                  text: l10n.save,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmitSaveButton(String groupId, AppLocalizations l10n) async {
    if (_isFormValidated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        loadingSnackBar(
          text: l10n.addingNewExpense,
        ),
      );

      String fileNameRef = '';
      if (image != null) {
        final file = File(image!.path);
        fileNameRef = await _storageService.uploadFile(file);
      }

      await _firestoreService.createExpense(
        _expenseNameFieldController.text,
        _expenseDescriptionFieldController.text,
        _date!,
        double.tryParse(_expenseAmountFieldController.text)!,
        _authService.currentUser!.uid,
        groupId,
        fileNameRef,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      int count = 0;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ExpensesScreen(
                  groupId: groupId,
                )),
        (_) => count++ >= 1,
      );
    }
  }

  _cameraButtonPressed() async {
    final _picker = ImagePicker();

    await Permission.camera.request();
    final permissionStatus = await Permission.camera.status;

    if (permissionStatus.isGranted) {
      final reveivedImage = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        image = reveivedImage;
      });
    }
  }

  _atachFileButtonPressed() async {
    final _picker = ImagePicker();

    await Permission.photos.request();
    final permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      final reveivedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = reveivedImage;
      });
    }
  }

  bool _isFormValidated() {
    final FormState form = formKey.currentState!;
    return form.validate();
  }
}
