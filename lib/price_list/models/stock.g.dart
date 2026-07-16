// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) => Stock(
  symbol: json['symbol'] as String,
  joint: (json['joint'] as num).toDouble(),
  change: (json['change'] as num).toDouble(),
  changePercent: (json['changePercent'] as num).toDouble(),
  volume: (json['volume'] as num).toDouble(),
);

Map<String, dynamic> _$StockToJson(Stock instance) => <String, dynamic>{
  'symbol': instance.symbol,
  'joint': instance.joint,
  'change': instance.change,
  'changePercent': instance.changePercent,
  'volume': instance.volume,
};

const _$StockJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'symbol': {'type': 'string'},
    'joint': {'type': 'number'},
    'change': {'type': 'number'},
    'changePercent': {'type': 'number'},
    'volume': {'type': 'number'},
  },
  'required': ['symbol', 'joint', 'change', 'changePercent', 'volume'],
};
