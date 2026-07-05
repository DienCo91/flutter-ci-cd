import 'package:batterylevel/web_socket_binance/binance_exchange_info/repository/binance_exchange_info_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'binance_exchange_info_event.dart';
part 'binance_exchange_info_state.dart';

class BinanceExchangeInfoBloc extends Bloc<BinanceExchangeInfoEvent, BinanceExchangeInfoState> {
  final BinanceExchangeInfoRepository _repository;

  BinanceExchangeInfoBloc({required BinanceExchangeInfoRepository repository})
    : _repository = repository,
      super(BinanceExchangeInfoState()) {
    on<BinanceExchangeInfoFetched>(_onBinanceExchangeInfoFetched);
  }

  void _onBinanceExchangeInfoFetched(BinanceExchangeInfoFetched event, Emitter<BinanceExchangeInfoState> emit) async {
    try {
      emit(state.copyWith(status: BinanceExchangeInfoStatus.loading));
      final res = await _repository.getExchangeInfo();
      emit(state.copyWith(listExchangeInfo: res["symbols"], status: BinanceExchangeInfoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: BinanceExchangeInfoStatus.failure));
    }
  }
}
