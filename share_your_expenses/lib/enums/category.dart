import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum GroupCategory {
  @JsonValue("couple")
  couple,
  @JsonValue("sharedHouse")
  sharedHouse,
  @JsonValue("event")
  event,
  @JsonValue("other")
  other,
}

extension GroupCategoryExtension on GroupCategory {
  String get name {
    return describeEnum(this);
  }

  IconData get iconData {
    switch (this) {
      case GroupCategory.couple:
        return Icons.people;
      case GroupCategory.sharedHouse:
        return Icons.house;
      case GroupCategory.event:
        return Icons.event;
      case GroupCategory.other:
        return Icons.question_answer;
      default:
        return Icons.question_answer;
    }
  }
}
