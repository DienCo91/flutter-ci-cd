import 'dart:convert';
import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketBinanceController extends GetxController {
  late WebSocketChannel channel;

  @override
  void onInit() async {
    super.onInit();
    print("WebSocketBinanceController initialized");

    final wsUrl = Uri.parse('wss://ws-api.binance.com:443/ws-api/v3');
    channel = WebSocketChannel.connect(wsUrl);

    await channel.ready;

    channel.stream.listen((message) {
      log("Received: $message");
    });
  }

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }

  void sendPingRequest() {
    final requestPayload = {
      "id": "1234",
      "method": "depth",
      "params": {"symbol": "BTCUSDT"},
    };

    channel.sink.add(jsonEncode(requestPayload));
  }
}
