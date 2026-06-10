// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanPurchase _$PlanPurchaseFromJson(Map<String, dynamic> json) => PlanPurchase(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  price: json['price'] as String?,
);

Map<String, dynamic> _$PlanPurchaseToJson(PlanPurchase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
    };

const _$PlanPurchaseJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'string'},
    'name': {'type': 'string'},
    'description': {'type': 'string'},
    'price': {'type': 'string'},
  },
  'required': ['id', 'name'],
};
