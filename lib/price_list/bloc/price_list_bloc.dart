import 'dart:async';
import 'dart:math';

import 'package:batterylevel/price_list/models/stock.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'price_list_event.dart';
part 'price_list_state.dart';

class PriceListBloc extends Bloc<PriceListEvent, PriceListState> {
  StreamSubscription? _mockSocketSub;

  PriceListBloc() : super(PriceListState()) {
    on<FetchLocalDataEvent>(_onFetchLocalData);
    on<SocketUpdateEvent>(_onSocketUpdate);
  }

  void _onFetchLocalData(
    FetchLocalDataEvent event,
    Emitter<PriceListState> emit,
  ) {
    final mockList = [
      const Stock(
        symbol: "ACB",
        joint: 22.70,
        change: 0.20,
        changePercent: 0.89,
        volume: 78110,
      ),
      const Stock(
        symbol: "BCM",
        joint: 62.80,
        change: -0.90,
        changePercent: -1.41,
        volume: 7860,
      ),
      const Stock(
        symbol: "BVH",
        joint: 40.00,
        change: -0.15,
        changePercent: -0.37,
        volume: 4100,
      ),
      const Stock(
        symbol: "CTG",
        joint: 26.65,
        change: -0.10,
        changePercent: -0.37,
        volume: 39000,
      ),
      const Stock(
        symbol: "FPT",
        joint: 96.00,
        change: -0.20,
        changePercent: -0.21,
        volume: 48400,
      ),
      const Stock(
        symbol: "BID",
        joint: 41.55,
        change: -0.05,
        changePercent: -0.12,
        volume: 5600,
      ),
      const Stock(
        symbol: "GVR",
        joint: 19.90,
        change: 0.05,
        changePercent: 0.25,
        volume: 2100,
      ),
      const Stock(
        symbol: "HDB",
        joint: 18.95,
        change: 0.05,
        changePercent: 0.26,
        volume: 16800,
      ),
      const Stock(
        symbol: "HPG",
        joint: 27.10,
        change: 0.05,
        changePercent: 0.18,
        volume: 4000,
      ),
    ];

    final symbols = <String>[];
    final marketData = <String, Stock>{};

    for (var stock in mockList) {
      symbols.add(stock.symbol);
      marketData[stock.symbol] = stock;
    }

    emit(state.copyWith(symbols: symbols, marketData: marketData));

    _startMockSocket();
  }

  void _onSocketUpdate(SocketUpdateEvent event, Emitter<PriceListState> emit) {
    final newMarketData = Map<String, Stock>.of(state.marketData ?? {});

    newMarketData[event.updatedStock.symbol] = event.updatedStock;

    emit(state.copyWith(marketData: newMarketData));
  }

  void _startMockSocket() {
    _mockSocketSub?.cancel();

    final random = Random();

    _mockSocketSub = Stream.periodic(const Duration(milliseconds: 500)).listen((
      _,
    ) {
      if (state.symbols.isEmpty) return;

      final randomSymbol = state.symbols[random.nextInt(state.symbols.length)];
      final oldStock = state.marketData?[randomSymbol];

      if (oldStock != null) {
        final priceFluc = (random.nextDouble() - 0.5);
        final newJoint = oldStock.joint + priceFluc;
        final newChange = oldStock.change + priceFluc;

        final updatedStock = oldStock.copyWith(
          joint: double.parse(newJoint.toStringAsFixed(2)),
          change: double.parse(newChange.toStringAsFixed(2)),
        );

        add(SocketUpdateEvent(updatedStock));
      }
    });
  }

  @override
  Future<void> close() {
    _mockSocketSub?.cancel();
    return super.close();
  }
}
