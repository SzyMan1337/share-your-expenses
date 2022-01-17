import 'package:json_annotation/json_annotation.dart';
import 'package:share_your_expenses/enums/role.dart';

part 'firestore_user.g.dart';

@JsonSerializable()
class FirestoreUser {
  final String id;
  final String userName;
  final List<UserRole> roles;
  final List<String> groups;

  const FirestoreUser({
    required this.id,
    required this.groups,
    required this.userName,
    required this.roles,
  });

  factory FirestoreUser.fromJson(Map<String, dynamic> json) =>
      _$FirestoreUserFromJson(json);
  Map<String, dynamic> toJson() => _$FirestoreUserToJson(this);
}
