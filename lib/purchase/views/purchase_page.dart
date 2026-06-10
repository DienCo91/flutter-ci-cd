import 'package:batterylevel/purchase/bloc/purchase_bloc.dart';
import 'package:batterylevel/purchase/views/purchase_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          final bloc = PurchaseBloc();
          bloc.add(LoadProductConsumerPurchaseEvent());
          bloc.add(LoadProductNonConsumerPurchaseEvent());
          bloc.add(LoadProductNonRenewSubPurchaseEvent());
          bloc.add(LoadProductAutoRenewSubPurchaseEvent());
          return bloc;
        },
        child: const PurchaseView(),
      ),
    );
  }
}
