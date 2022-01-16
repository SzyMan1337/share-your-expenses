// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      currency: json['currency'] as String,
      category: $enumDecodeNullable(_$GroupCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': _$GroupCategoryEnumMap[instance.category],
      'members': instance.members,
      'currency': instance.currency,
    };

const _$GroupCategoryEnumMap = {
  GroupCategory.couple: 'couple',
  GroupCategory.sharedHouse: 'sharedHouse',
  GroupCategory.event: 'event',
  GroupCategory.other: 'other',
};
