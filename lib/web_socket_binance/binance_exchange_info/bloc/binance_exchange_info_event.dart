part of 'binance_exchange_info_bloc.dart';

@immutable
sealed class BinanceExchangeInfoEvent {}

class BinanceExchangeInfoFetched extends BinanceExchangeInfoEvent {}
