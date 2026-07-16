import 'package:batterylevel/web_socket_binance/binance_trading/bloc/binance_trading_bloc.dart';
import 'package:batterylevel/web_socket_binance/binance_trading/models/agg_trade.dart';
import 'package:batterylevel/web_socket_binance/binance_trading/views/binance_agg_trade.dart';
import 'package:batterylevel/web_socket_binance/binance_trading/views/buy_sell_ratio_bar.dart';
import 'package:batterylevel/web_socket_binance/binance_trading/views/flashing_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BinanceTradingList extends StatelessWidget {
  const BinanceTradingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          color: Colors.red[400],
          child: Text('Asks (Bán - USD)', style: Theme.of(context).textTheme.titleLarge),
        ),
        Expanded(
          child: BlocBuilder<BinanceTradingBloc, BinanceTradingState>(
            buildWhen: (previous, current) => previous.listAsks != current.listAsks,
            builder: (context, state) {
              if (state.status == BinanceTradingStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == BinanceTradingStatus.failure) {
                return const Center(child: Text('Failed to fetch trading data'));
              } else if (state.listAsks.isEmpty) {
                return const Center(child: Text('No trading data available'));
              }
              return ListView.builder(
                itemExtent: 30,
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: state.listAsks.length,
                itemBuilder: (context, index) {
                  final listAsks = state.listAsks[index];
                  return RepaintBoundary(
                    child: Row(
                      children: [
                        Expanded(child: FlashingCell(textValue: '${listAsks[0]}')),
                        Expanded(child: FlashingCell(textValue: ' ${listAsks[1]}')),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),

        Divider(height: 1.0, color: Colors.grey[400]),
        BlocBuilder<BinanceTradingBloc, BinanceTradingState>(
          buildWhen: (previous, current) => previous.aggTrade != current.aggTrade,
          builder: (context, state) {
            if (state.status == BinanceTradingStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == BinanceTradingStatus.failure) {
              return SizedBox();
            } else if (state.aggTrade == null) {
              return SizedBox();
            }
            return BinanceAggTrade(aggTrade: state.aggTrade ?? AggTrade());
          },
        ),
        Divider(height: 1.0, color: Colors.grey[400]),

        Expanded(
          child: BlocBuilder<BinanceTradingBloc, BinanceTradingState>(
            buildWhen: (previous, current) => previous.listBids != current.listBids,
            builder: (context, state) {
              if (state.status == BinanceTradingStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == BinanceTradingStatus.failure) {
                return const Center(child: Text('Failed to fetch trading data'));
              } else if (state.listBids.isEmpty) {
                return const Center(child: Text('No trading data available'));
              }
              return ListView.builder(
                itemExtent: 30,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: state.listBids.length,
                itemBuilder: (context, index) {
                  final listBids = state.listBids[index];
                  return RepaintBoundary(
                    child: Row(
                      children: [
                        Expanded(child: FlashingCell(textValue: '${listBids[0]}')),
                        Expanded(child: FlashingCell(textValue: ' ${listBids[1]}')),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        Container(
          color: Colors.green[400],
          child: Text('Bids (Mua - USD)', style: Theme.of(context).textTheme.titleLarge),
        ),

        BlocBuilder<BinanceTradingBloc, BinanceTradingState>(
          buildWhen: (previous, current) =>
              previous.listBids != current.listBids || previous.listAsks != current.listAsks,
          builder: (context, state) {
            if (state.listBids.isEmpty || state.listAsks.isEmpty) {
              return const SizedBox();
            }
            return BuySellRatioBar(listBids: state.listBids, listAsks: state.listAsks);
          },
        ),
      ],
    );
  }
}
