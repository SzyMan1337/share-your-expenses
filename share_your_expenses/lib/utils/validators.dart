import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validators {
  Validators(this.l10n);
  final AppLocalizations l10n;

  String? validateEmail(String? value) {
    final regx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) {
      return l10n.emailCantBeEmpty;
    } else if (!regx.hasMatch(value)) {
      return l10n.emailIsNotValid;
    }
    return null;
  }

  String? validatePassword(String? value) {
    return value == null || value.isEmpty ? l10n.passwordCantBeEmpty : null;
  }

  String? validateGroupName(String? value) {
    return value == null || value.isEmpty ? l10n.groupNameCantBeEmpty : null;
  }

  String? validateGroupCurrency(String? value) {
    if (value == null || value.isEmpty) {
      return l10n.groupCurrencyCantBeEmpty;
    }
    return null;
  }

  String? validateExpenseName(String? value) {
    return value == null || value.isEmpty ? l10n.expenseNameCantBeEmpty : null;
  }

  String? validateExpenseAmount(String? value) {
    if (value == null || value.isEmpty) return l10n.expenseAmountCantBeEmpty;

    if (double.tryParse(value) == null) {
      return l10n.expenseHasToBeNumerical;
    }
    return null;
  }

  String? validateExpenseDate(String? value) {
    if (value == null || value.isEmpty) return l10n.expenseDateCantBeEmpty;

    if (DateTime.tryParse(value) == null) {
      return l10n.inputCorrectDate;
    }
    return null;
  }

  String? validateUserName(String? value) {
    final regx = RegExp("[^a-z^A-Z^0-9]+");
    if (value == null || value.isEmpty) {
      return l10n.usernameCantBeEmpty;
    } else if (regx.hasMatch(value)) {
      return l10n.usernameIsNotValid;
    } else if (value.length > 20) {
      return l10n.usernameCantBeLonger;
    }

    return null;
  }
}
