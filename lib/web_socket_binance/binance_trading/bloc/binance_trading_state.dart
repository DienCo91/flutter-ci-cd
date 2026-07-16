part of 'binance_trading_bloc.dart';

enum BinanceTradingStatus { initial, loading, success, failure }

final class BinanceTradingState {
  final List<dynamic> listBids;
  final List<dynamic> listAsks;
  final AggTrade? aggTrade;
  final BinanceTradingStatus status;
  BinanceTradingState({
    this.listBids = const [],
    this.listAsks = const [],
    this.aggTrade,
    this.status = BinanceTradingStatus.initial,
  });

  BinanceTradingState copyWith({
    List<dynamic>? listBids,
    List<dynamic>? listAsks,
    BinanceTradingStatus? status,
    AggTrade? aggTrade,
  }) {
    return BinanceTradingState(
      listBids: listBids ?? this.listBids,
      listAsks: listAsks ?? this.listAsks,
      status: status ?? this.status,
      aggTrade: aggTrade ?? this.aggTrade,
    );
  }
}
