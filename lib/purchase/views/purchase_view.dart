import 'package:batterylevel/purchase/bloc/purchase_bloc.dart';
import 'package:batterylevel/purchase/views/purchase_auto_renew_sub.dart';
import 'package:batterylevel/purchase/views/purchase_consumable.dart';
import 'package:batterylevel/purchase/views/purchase_non_consumable.dart';
import 'package:batterylevel/purchase/views/purchase_non_renew_sub.dart';
import 'package:batterylevel/utils/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchaseView extends StatelessWidget {
  const PurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
    void handleChoosePlan() {
      context.read<PurchaseBloc>().add(SubmitPurchaseEvent());
    }

    void handleOffersCode() {
      context.read<PurchaseBloc>().add(ShowOfferCodeSheetEvent());
    }

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.background),
            fit: BoxFit.fill,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                PurchaseConsumable(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: Colors.white),
                ),
                PurchaseNonConsumable(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: Colors.white),
                ),
                PurchaseNonRenewSub(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: Colors.white),
                ),
                PurchaseAutoRenewSub(),

                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleChoosePlan,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.blueAccent,
                      ),
                    ),
                    child: const Text(
                      "Select Plan",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleOffersCode,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.blueAccent,
                      ),
                    ),
                    child: const Text(
                      "Offers Code",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
