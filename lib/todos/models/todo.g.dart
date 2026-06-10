// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
  title: json['title'] as String?,
  id: json['id'] as String?,
  isComplete: json['isComplete'] as bool?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
  'title': instance.title,
  'id': instance.id,
  'createdAt': instance.createdAt,
  'isComplete': instance.isComplete,
};

const _$TodoJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'title': {'type': 'string'},
    'id': {'type': 'string'},
    'createdAt': {'type': 'string'},
    'isComplete': {'type': 'boolean'},
  },
};
