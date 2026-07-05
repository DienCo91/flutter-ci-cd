import 'package:batterylevel/web_socket_binance/binance_exchange_info/bloc/binance_exchange_info_bloc.dart';
import 'package:batterylevel/web_socket_binance/binance_exchange_info/views/item_exchange_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListExchangeInfo extends StatelessWidget {
  const ListExchangeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BinanceExchangeInfoBloc, BinanceExchangeInfoState>(
      builder: (context, state) {
        if (state.status == BinanceExchangeInfoStatus.failure) {
          return const Center(child: Text('Failed to load exchange info'));
        }
        if (state.status == BinanceExchangeInfoStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: state.listExchangeInfo.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ItemExchangeInfo(index: index, state: state),
            );
          },
        );
      },
    );
  }
}
