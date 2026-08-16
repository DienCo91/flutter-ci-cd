import 'package:batterylevel/price_list/bloc/price_list_bloc.dart';
import 'package:batterylevel/price_list/views/row_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceListPage extends StatelessWidget {
  const PriceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price List')),
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            final bloc = PriceListBloc();
            bloc.add(FetchLocalDataEvent());
            return bloc;
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(flex: 1, child: Text('Mã')),
                    Expanded(flex: 1, child: Text('Khớp')),
                    Expanded(flex: 1, child: Text('+/-')),
                    Expanded(flex: 1, child: Text('+/-%')),
                    Expanded(flex: 1, child: Text('KL')),
                  ],
                ),
                BlocBuilder<PriceListBloc, PriceListState>(
                  buildWhen: (previous, current) =>
                      previous.symbols != current.symbols,
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.symbols.length,
                      itemBuilder: (context, index) {
                        final symbol = state.symbols[index];
                        return Row(
                          children: [
                            RowItem(
                              index: index,
                              symbol: symbol,
                              onSelect: (bloc) =>
                                  bloc.state.marketData?[symbol]?.symbol ?? '',
                            ),
                            RowItem(
                              index: index,
                              symbol: symbol,
                              onSelect: (bloc) =>
                                  bloc.state.marketData?[symbol]?.joint ?? 0,
                            ),
                            RowItem(
                              index: index,
                              symbol: symbol,
                              onSelect: (bloc) =>
                                  bloc.state.marketData?[symbol]?.change ?? 0,
                            ),
                            RowItem(
                              index: index,
                              symbol: symbol,
                              onSelect: (bloc) =>
                                  bloc
                                      .state
                                      .marketData?[symbol]
                                      ?.changePercent ??
                                  0,
                            ),
                            RowItem(
                              index: index,
                              symbol: symbol,
                              onSelect: (bloc) =>
                                  bloc.state.marketData?[symbol]?.volume ?? 0,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
