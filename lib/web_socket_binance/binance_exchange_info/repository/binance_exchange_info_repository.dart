import 'package:dio/dio.dart';

class BinanceExchangeInfoRepository {
  final dio = Dio();
  final String _baseUrl = "https://api.binance.com/api/v3";

  Future<Map<String, dynamic>> getExchangeInfo() async {
    try {
      final res = await dio.get('$_baseUrl/exchangeInfo?symbolStatus=TRADING');
      return res.data;
    } catch (e) {
      throw Exception('Load exchange info error: $e');
    }
  }
}
