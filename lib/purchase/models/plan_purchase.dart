import 'package:json_annotation/json_annotation.dart';

part 'plan_purchase.g.dart';

@JsonSerializable(createJsonSchema: true)
class PlanPurchase {
  final String? id;
  final String? name;
  final String? description;
  final String? price;

  PlanPurchase({required this.id, required this.name, this.description, this.price});

  factory PlanPurchase.fromJson(Map<String, dynamic> json) => _$PlanPurchaseFromJson(json);

  Map<String, dynamic> toJson() => _$PlanPurchaseToJson(this);

  static const jsonSchema = _$PlanPurchaseJsonSchema;
}
