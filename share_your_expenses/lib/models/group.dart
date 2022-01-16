import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String? id;
  final String name;
  final String description;
  // final Category category;
  final List<String> members;
  final String currency;

  const Group({
    this.id,
    required this.name,
    required this.description,
    required this.members,
    required this.currency,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
