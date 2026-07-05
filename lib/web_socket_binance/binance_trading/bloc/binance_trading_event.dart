part of 'binance_trading_bloc.dart';

@immutable
sealed class BinanceTradingEvent {}

class GetBinanceTradingEvent extends BinanceTradingEvent {
  final String symbol;
  GetBinanceTradingEvent(this.symbol);
}

class GetAggTradeBySymbolEvent extends BinanceTradingEvent {
  final String symbol;
  GetAggTradeBySymbolEvent(this.symbol);
}

class StartListeningOrderBookEvent extends BinanceTradingEvent {
  final String symbol;
  StartListeningOrderBookEvent(this.symbol);
}
