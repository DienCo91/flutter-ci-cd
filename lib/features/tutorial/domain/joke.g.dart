// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joke _$JokeFromJson(Map<String, dynamic> json) => Joke(
  type: json['type'] as String,
  setup: json['setup'] as String,
  punchline: json['punchline'] as String,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$JokeToJson(Joke instance) => <String, dynamic>{
  'type': instance.type,
  'setup': instance.setup,
  'punchline': instance.punchline,
  'id': instance.id,
};

const _$JokeJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'type': {'type': 'string'},
    'setup': {'type': 'string'},
    'punchline': {'type': 'string'},
    'id': {'type': 'integer'},
  },
  'required': ['type', 'setup', 'punchline', 'id'],
};
