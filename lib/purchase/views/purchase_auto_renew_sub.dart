import 'package:batterylevel/purchase/bloc/purchase_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseAutoRenewSub extends StatelessWidget {
  const PurchaseAutoRenewSub({super.key});

  @override
  Widget build(BuildContext context) {
    void handleChoosePlan({required ProductDetails productDetails}) {
      context.read<PurchaseBloc>().add(ChoosePlanPurchaseEvent(productDetails: productDetails));
    }

    return BlocBuilder<PurchaseBloc, PurchaseState>(
      builder: (context, state) {
        if (state.plansAutoRenewSub.isEmpty) {
          return SizedBox.shrink();
        }
        return Column(
          children: [
            Text(
              'Choose Your Plan Auto Renew Sub',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            ListView.builder(
              itemExtent: 128,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.plansAutoRenewSub.length,
              itemBuilder: (context, index) {
                final isActive = state.plansAutoRenewSub[index].id == state.selectedProductDetail?.id;

                return AnimatedScale(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  scale: isActive ? 1 : 0.97,
                  child: AnimatedContainer(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white.withValues(alpha: 0.55) : Colors.white.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isActive ? Colors.white : Colors.transparent, width: isActive ? 2 : 1),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isActive ? 0.25 : 0.08),
                          blurRadius: isActive ? 16 : 4,
                          offset: Offset(0, isActive ? 8 : 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => handleChoosePlan(productDetails: state.plansAutoRenewSub[index]),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 100),
                            style: TextStyle(
                              color: isActive ? Colors.black : Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: isActive ? 19 : 18,
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(state.plansAutoRenewSub[index].title),
                                    const Spacer(),
                                    Text(state.plansAutoRenewSub[index].price),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.plansAutoRenewSub[index].description,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 8),
                                // Container(
                                //   width: double.infinity,
                                //   decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(16)),
                                //   child: TextButton.icon(
                                //     onPressed: () => handleCancel(productDetails: state.plansAutoRenewSub[index]),
                                //     label: Text("CANCEL", style: TextStyle(color: Colors.white)),
                                //     icon: Icon(Icons.cancel, color: Colors.white),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
