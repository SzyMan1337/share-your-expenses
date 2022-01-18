import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense {
  final String? id;
  final String name;
  final String description;
  final double amount;
  final String userId;
  final String photo;

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime date;

  const Expense({
    required this.name,
    required this.description,
    required this.amount,
    required this.userId,
    required this.date,
    required this.photo,
    this.id,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

  static DateTime _fromJson(Timestamp timestamp) => timestamp.toDate();
  static FieldValue _toJson(DateTime time) => FieldValue.serverTimestamp();
}
