class ApiPath {
  static String get users => 'Users';
  static String user(String userId) => 'Users/$userId';
  static String userGroups(String userId) => 'Users/$userId/Groups';
  static String groupExpenses(String groupId) => 'Groups/$groupId';
}
