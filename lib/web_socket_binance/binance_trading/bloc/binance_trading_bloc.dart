import 'package:batterylevel/web_socket_binance/binance_trading/models/agg_trade.dart';
import 'package:batterylevel/web_socket_binance/binance_trading/repository/binance_trading_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'binance_trading_event.dart';
part 'binance_trading_state.dart';

class BinanceTradingBloc
    extends Bloc<BinanceTradingEvent, BinanceTradingState> {
  final BinanceTradingRepository _repository;

  BinanceTradingBloc({required BinanceTradingRepository repository})
    : _repository = repository,
      super(BinanceTradingState()) {
    on<GetBinanceTradingEvent>(_onBinanceTradingFetched);
    on<StartListeningOrderBookEvent>(_onStartListeningOrderBook);
    on<GetAggTradeBySymbolEvent>(_onGetAggTradeBySymbol);
  }

  void _onBinanceTradingFetched(
    GetBinanceTradingEvent event,
    Emitter<BinanceTradingState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BinanceTradingStatus.loading));
      final data = await _repository.getTradingBySymbol(symbol: event.symbol);
      print('=====_onBinanceTradingFetched: $data');
      emit(
        state.copyWith(
          listBids: data["bids"],
          listAsks: data["asks"],
          status: BinanceTradingStatus.success,
        ),
      );
    } catch (e) {
      print('=====Error: $e');
      emit(state.copyWith(status: BinanceTradingStatus.failure));
    }
  }

  void _onGetAggTradeBySymbol(
    GetAggTradeBySymbolEvent event,
    Emitter<BinanceTradingState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BinanceTradingStatus.loading));
      final data = await _repository.getAggTradeBySymbol(symbol: event.symbol);
      print('=====_onGetAggTradeBySymbol: $data');
      emit(
        state.copyWith(
          aggTrade: AggTrade.fromJson(data),
          status: BinanceTradingStatus.success,
        ),
      );
    } catch (e) {
      print('=====Error: $e');
      emit(state.copyWith(status: BinanceTradingStatus.failure));
    }
  }

  void _onStartListeningOrderBook(
    StartListeningOrderBookEvent event,
    Emitter<BinanceTradingState> emit,
  ) async {
    await emit.forEach<Map<String, dynamic>>(
      _repository.getOrderBookStream(symbol: event.symbol),
      onData: (res) {
        // print('=====wss: $res');

        final stream = res['stream'] as String?;
        final data = res['data'] as Map<String, dynamic>?;

        if (stream != null && stream.contains('depth')) {
          return state.copyWith(
            status: BinanceTradingStatus.success,
            listBids: data?['bids'] ?? [],
            listAsks: data?['asks'] ?? [],
          );
        } else if (stream != null && stream.contains('aggTrade')) {
          return state.copyWith(
            status: BinanceTradingStatus.success,
            aggTrade: AggTrade.fromJson(data ?? {}),
          );
        }

        return state.copyWith(status: BinanceTradingStatus.success);
      },
      onError: (error, stackTrace) {
        return state.copyWith(status: BinanceTradingStatus.failure);
      },
    );
  }
}
