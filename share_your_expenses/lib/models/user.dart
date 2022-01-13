import 'package:json_annotation/json_annotation.dart';
import 'package:share_your_expenses/enums/role.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String userName;
  final List<UserRole> roles;
  final List<String> groups;

  const User({
    required this.groups,
    required this.userName,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
