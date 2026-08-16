import 'package:batterylevel/web_socket_binance/binance_exchange_info/bloc/binance_exchange_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemExchangeInfo extends StatelessWidget {
  final BinanceExchangeInfoState state;
  final int index;

  const ItemExchangeInfo({super.key, required this.state, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.go('/binance_exchange_info/binance_trading', extra: state.listExchangeInfo[index]["symbol"]);
      },
      title: Text(state.listExchangeInfo[index]["symbol"]),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Status: ${state.listExchangeInfo[index]["status"]}"),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Base Asset: ${state.listExchangeInfo[index]["baseAsset"]}", style: TextStyle(fontSize: 14)),
              Text("Quote Asset: ${state.listExchangeInfo[index]["quoteAsset"]}", style: TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
