import 'package:flutter/foundation.dart';

enum GroupCategory {
  couple,
  trip,
  sharedHouse,
  event,
  project,
  other,
}

extension UserRoleExtension on GroupCategory {
  String get name {
    return describeEnum(this);
  }
}
