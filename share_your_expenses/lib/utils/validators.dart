class Validators {
  static String? validateEmail(String? value) {
    final regx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!regx.hasMatch(value)) {
      return 'Email is not valid';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    return value == null || value.isEmpty ? 'Password can\'t be empty' : null;
  }

  static String? validateGroupName(String? value) {
    return value == null || value.isEmpty ? 'Group name can\'t be empty' : null;
  }

  static String? validateExpenseName(String? value) {
    return value == null || value.isEmpty
        ? 'Expense name can\'t be empty'
        : null;
  }

  static String? validateUserName(String? value) {
    final regx = RegExp("[^a-z^A-Z^0-9]+");
    if (value == null || value.isEmpty) {
      return 'Username can\'t be empty';
    } else if (regx.hasMatch(value)) {
      return 'Username is not valid';
    }
    return null;
  }
}
