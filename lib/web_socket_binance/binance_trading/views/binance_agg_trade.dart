import 'package:batterylevel/web_socket_binance/binance_trading/models/agg_trade.dart';
import 'package:material_ui/material_ui.dart';

class BinanceAggTrade extends StatelessWidget {
  final AggTrade aggTrade;
  const BinanceAggTrade({super.key, required this.aggTrade});

  @override
  Widget build(BuildContext context) {
    final isBuyerMaker = aggTrade.isBuyerMaker == false;
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${aggTrade.price}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isBuyerMaker ? Colors.green[400] : Colors.red[400],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  '${aggTrade.quantity}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isBuyerMaker ? Colors.green[400] : Colors.red[400],
                  ),
                ),
                isBuyerMaker
                    ? Icon(Icons.arrow_upward, color: Colors.green[400])
                    : Icon(Icons.arrow_downward, color: Colors.red[400]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
