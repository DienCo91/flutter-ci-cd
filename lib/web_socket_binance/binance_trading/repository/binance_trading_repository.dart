import 'dart:convert';

import 'package:batterylevel/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceTradingRepository {
  BinanceTradingRepository({Dio? dio}) : _dio = dio ?? DioClient().dio;

  final Dio _dio;
  final String _baseUrl = "https://api.binance.com/api/v3";
  final String _wsUrl = "wss://stream.binance.com:9443";
  WebSocketChannel? _channel;
  final int TOTAL_DEPTH = 10;

  Future<Map<String, dynamic>> getTradingBySymbol({
    required String symbol,
  }) async {
    try {
      final res = await _dio.get(
        '$_baseUrl/depth?symbol=$symbol&limit=$TOTAL_DEPTH',
      );
      return res.data;
    } catch (e) {
      throw Exception('Load trading pairs error: $e');
    }
  }

  Future<Map<String, dynamic>> getAggTradeBySymbol({
    required String symbol,
  }) async {
    try {
      final res = await _dio.get('$_baseUrl/aggTrades?symbol=$symbol&limit=1');
      return res.data[0];
    } catch (e) {
      throw Exception('Load trading pairs error: $e');
    }
  }

  Stream<Map<String, dynamic>> getOrderBookStream({required String symbol}) {
    final symbolLower = symbol.toLowerCase();
    final url =
        '$_wsUrl/stream?streams=$symbolLower@depth$TOTAL_DEPTH@100ms/$symbolLower@aggTrade';
    _channel = WebSocketChannel.connect(Uri.parse(url));

    return _channel!.stream.map((rawMessage) => jsonDecode(rawMessage));
  }

  void closeConnection() {
    _channel?.sink.close();
  }
}
