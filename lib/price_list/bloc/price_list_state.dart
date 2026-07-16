part of 'price_list_bloc.dart';

final class PriceListState extends Equatable {
  final List<String> symbols;
  final Map<String, Stock>? marketData;

  const PriceListState({this.symbols = const [], this.marketData});

  PriceListState copyWith({List<String>? symbols, Map<String, Stock>? marketData}) {
    return PriceListState(symbols: symbols ?? this.symbols, marketData: marketData ?? this.marketData);
  }

  @override
  List<Object?> get props => [symbols, marketData];
}
