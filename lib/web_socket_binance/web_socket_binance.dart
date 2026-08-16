import 'package:batterylevel/web_socket_binance/binance_exchange_info/bloc/binance_exchange_info_bloc.dart';
import 'package:batterylevel/web_socket_binance/binance_exchange_info/repository/binance_exchange_info_repository.dart';
import 'package:batterylevel/web_socket_binance/binance_exchange_info/views/list_exchange_info.dart';
import 'package:batterylevel/web_socket_binance/web_socket_binance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/state_manager.dart';

class WebSocketBinance extends GetView<WebSocketBinanceController> {
  const WebSocketBinance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Binance Exchange Info')),
      body: RepositoryProvider(
        create: (context) => BinanceExchangeInfoRepository(),
        child: BlocProvider(
          create: (context) {
            final bloc = BinanceExchangeInfoBloc(
              repository: context.read<BinanceExchangeInfoRepository>(),
            );
            bloc.add(BinanceExchangeInfoFetched());
            return bloc;
          },
          child: SafeArea(child: ListExchangeInfo()),
        ),
      ),
    );
  }
}
