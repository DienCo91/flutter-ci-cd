part of 'binance_exchange_info_bloc.dart';

enum BinanceExchangeInfoStatus { initial, loading, success, failure }

class BinanceExchangeInfoState {
  final List<dynamic> listExchangeInfo;
  final BinanceExchangeInfoStatus status;

  const BinanceExchangeInfoState({
    this.listExchangeInfo = const [],
    this.status = BinanceExchangeInfoStatus.initial,
  });
  BinanceExchangeInfoState copyWith({
    List<dynamic>? listExchangeInfo,
    BinanceExchangeInfoStatus? status,
  }) {
    return BinanceExchangeInfoState(
      listExchangeInfo: listExchangeInfo ?? this.listExchangeInfo,
      status: status ?? this.status,
    );
  }
}
