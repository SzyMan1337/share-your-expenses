class ApiPath {
  static String get users => 'Users';
  static String user(String userId) => 'Users/$userId';
  static String userGroups(String userId) => 'Users/$userId/Groups';
  static String get groups => 'Groups';
  static String group(String groupId) => 'Groups/$groupId';
  static String groupExpenses(String groupId) => 'Groups/$groupId/Expenses';
  static String groupExpense(String groupId, String expenseId) =>
      'Groups/$groupId/Expenses/$expenseId';
}
