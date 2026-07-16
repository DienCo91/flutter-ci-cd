// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agg_trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AggTrade _$AggTradeFromJson(Map<String, dynamic> json) => AggTrade(
  eventType: json['e'] as String?,
  eventTime: (json['E'] as num?)?.toInt(),
  symbol: json['s'] as String?,
  aggTradeId: (json['a'] as num?)?.toInt(),
  price: json['p'] as String?,
  quantity: json['q'] as String?,
  firstTradeId: (json['f'] as num?)?.toInt(),
  lastTradeId: (json['l'] as num?)?.toInt(),
  tradeTime: (json['T'] as num?)?.toInt(),
  isBuyerMaker: json['m'] as bool?,
  ignoreData: json['M'] as bool?,
);

Map<String, dynamic> _$AggTradeToJson(AggTrade instance) => <String, dynamic>{
  'e': instance.eventType,
  'E': instance.eventTime,
  's': instance.symbol,
  'a': instance.aggTradeId,
  'p': instance.price,
  'q': instance.quantity,
  'f': instance.firstTradeId,
  'l': instance.lastTradeId,
  'T': instance.tradeTime,
  'm': instance.isBuyerMaker,
  'M': instance.ignoreData,
};
