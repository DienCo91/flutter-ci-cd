// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dog _$DogFromJson(Map<String, dynamic> json) => Dog(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  age: (json['age'] as num).toInt(),
);

Map<String, dynamic> _$DogToJson(Dog instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'age': instance.age,
};

const _$DogJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'name': {'type': 'string'},
    'age': {'type': 'integer'},
  },
  'required': ['id', 'name', 'age'],
};
