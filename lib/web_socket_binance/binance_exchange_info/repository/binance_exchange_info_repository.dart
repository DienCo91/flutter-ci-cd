import 'package:batterylevel/core/network/dio_client.dart';
import 'package:dio/dio.dart';

class BinanceExchangeInfoRepository {
  BinanceExchangeInfoRepository({Dio? dio}) : _dio = dio ?? DioClient().dio;

  final Dio _dio;
  final String _baseUrl = "https://api.binance.com/api/v3";

  Future<Map<String, dynamic>> getExchangeInfo() async {
    try {
      final res = await _dio.get('$_baseUrl/exchangeInfo?symbolStatus=TRADING');
      return res.data;
    } catch (e) {
      throw Exception('Load exchange info error: $e');
    }
  }
}
