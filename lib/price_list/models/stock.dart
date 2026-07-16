import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock.g.dart';

@JsonSerializable(createJsonSchema: true)
class Stock extends Equatable {
  final String symbol;
  final double joint;
  final double change;
  final double changePercent;
  final double volume;

  const Stock({
    required this.symbol,
    required this.joint,
    required this.change,
    required this.changePercent,
    required this.volume,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this);

  static const jsonSchema = _$StockJsonSchema;

  @override
  List<Object?> get props => [symbol, joint, change, changePercent, volume];

  Stock copyWith({String? symbol, double? joint, double? change, double? changePercent, double? volume}) {
    return Stock(
      symbol: symbol ?? this.symbol,
      joint: joint ?? this.joint,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      volume: volume ?? this.volume,
    );
  }
}
