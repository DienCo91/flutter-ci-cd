import 'package:material_ui/material_ui.dart';

class BuySellRatioBar extends StatelessWidget {
  final List<dynamic> listBids;
  final List<dynamic> listAsks;

  const BuySellRatioBar({
    super.key,
    required this.listBids,
    required this.listAsks,
  });

  @override
  Widget build(BuildContext context) {
    double totalBidVolume = 0.0;
    for (var bid in listBids) {
      totalBidVolume += double.tryParse(bid[1].toString()) ?? 0.0;
    }

    double totalAskVolume = 0.0;
    for (var ask in listAsks) {
      totalAskVolume += double.tryParse(ask[1].toString()) ?? 0.0;
    }

    double totalVolume = totalBidVolume + totalAskVolume;
    if (totalVolume == 0) return const SizedBox();

    double buyPercent = (totalBidVolume / totalVolume) * 100;
    double sellPercent = (totalAskVolume / totalVolume) * 100;

    String buyText = buyPercent.toStringAsFixed(2).replaceAll('.', ',');
    String sellText = sellPercent.toStringAsFixed(2).replaceAll('.', ',');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Text(
            'B $buyText%',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),

          const SizedBox(width: 8.0),

          Expanded(
            child: SizedBox(
              height: 4.0,
              child: Row(
                children: [
                  Expanded(
                    flex: (buyPercent * 100).toInt(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),

                  const SizedBox(width: 2.0),

                  Expanded(
                    flex: (sellPercent * 100).toInt(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8.0),

          Text(
            '$sellText% S',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
