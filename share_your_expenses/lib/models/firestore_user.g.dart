// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreUser _$FirestoreUserFromJson(Map<String, dynamic> json) =>
    FirestoreUser(
      id: json['id'] as String,
      groups:
          (json['groups'] as List<dynamic>).map((e) => e as String).toList(),
      userName: json['userName'] as String,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => $enumDecode(_$UserRoleEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$FirestoreUserToJson(FirestoreUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'roles': instance.roles.map((e) => _$UserRoleEnumMap[e]).toList(),
      'groups': instance.groups,
    };

const _$UserRoleEnumMap = {
  UserRole.customer: 'customer',
  UserRole.admin: 'admin',
  UserRole.unknown: 'unknown',
};
