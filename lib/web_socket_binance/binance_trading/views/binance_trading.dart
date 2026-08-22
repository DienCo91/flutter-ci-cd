import 'package:batterylevel/web_socket_binance/binance_trading/bloc/binance_trading_bloc.dart';
import 'package:batterylevel/web_socket_binance/binance_trading/repository/binance_trading_repository.dart';
import 'package:batterylevel/web_socket_binance/binance_trading/views/binance_trading_list.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BinanceTrading extends StatelessWidget {
  final String symbol;
  const BinanceTrading({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Binance Trading')),
      body: SafeArea(
        child: RepositoryProvider(
          create: (context) => BinanceTradingRepository(),
          child: BlocProvider(
            create: (context) {
              final bloc = BinanceTradingBloc(
                repository: context.read<BinanceTradingRepository>(),
              );
              bloc.add(GetBinanceTradingEvent(symbol));
              bloc.add(GetAggTradeBySymbolEvent(symbol));
              bloc.add(StartListeningOrderBookEvent(symbol));

              return bloc;
            },
            child: const BinanceTradingList(),
          ),
        ),
      ),
    );
  }
}
