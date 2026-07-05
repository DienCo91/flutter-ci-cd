import 'package:json_annotation/json_annotation.dart';

part 'agg_trade.g.dart';

@JsonSerializable()
class AggTrade {
  @JsonKey(name: 'e')
  final String? eventType;

  @JsonKey(name: 'E')
  final int? eventTime;

  @JsonKey(name: 's')
  final String? symbol;

  @JsonKey(name: 'a')
  final int? aggTradeId;

  @JsonKey(name: 'p')
  final String? price;

  @JsonKey(name: 'q')
  final String? quantity;

  @JsonKey(name: 'f')
  final int? firstTradeId;

  @JsonKey(name: 'l')
  final int? lastTradeId;

  @JsonKey(name: 'T')
  final int? tradeTime;

  @JsonKey(name: 'm')
  final bool? isBuyerMaker;

  @JsonKey(name: 'M')
  final bool? ignoreData;

  AggTrade({
    this.eventType,
    this.eventTime,
    this.symbol,
    this.aggTradeId,
    this.price,
    this.quantity,
    this.firstTradeId,
    this.lastTradeId,
    this.tradeTime,
    this.isBuyerMaker,
    this.ignoreData,
  });

  factory AggTrade.fromJson(Map<String, dynamic> json) => _$AggTradeFromJson(json);

  Map<String, dynamic> toJson() => _$AggTradeToJson(this);

  AggTrade copyWith({
    String? eventType,
    int? eventTime,
    String? symbol,
    int? aggTradeId,
    String? price,
    String? quantity,
    int? firstTradeId,
    int? lastTradeId,
    int? tradeTime,
    bool? isBuyerMaker,
    bool? ignoreData,
  }) {
    return AggTrade(
      eventType: eventType ?? this.eventType,
      eventTime: eventTime ?? this.eventTime,
      symbol: symbol ?? this.symbol,
      aggTradeId: aggTradeId ?? this.aggTradeId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      firstTradeId: firstTradeId ?? this.firstTradeId,
      lastTradeId: lastTradeId ?? this.lastTradeId,
      tradeTime: tradeTime ?? this.tradeTime,
      isBuyerMaker: isBuyerMaker ?? this.isBuyerMaker,
      ignoreData: ignoreData ?? this.ignoreData,
    );
  }
}
