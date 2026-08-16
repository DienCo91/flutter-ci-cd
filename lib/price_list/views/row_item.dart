import 'package:batterylevel/price_list/bloc/price_list_bloc.dart';
import 'package:batterylevel/web_socket_binance/binance_trading/views/flashing_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RowItem extends StatelessWidget {
  final String symbol;
  final num index;
  final Function(PriceListBloc bloc) onSelect;
  const RowItem({
    super.key,
    required this.symbol,
    required this.onSelect,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final field = context.select(onSelect);

    return Expanded(flex: 1, child: FlashingCell(textValue: "$field"));
  }
}
