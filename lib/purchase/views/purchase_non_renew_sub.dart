import 'package:batterylevel/purchase/bloc/purchase_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseNonRenewSub extends StatelessWidget {
  const PurchaseNonRenewSub({super.key});

  @override
  Widget build(BuildContext context) {
    void handleChoosePlan({required ProductDetails productDetails}) {
      context.read<PurchaseBloc>().add(
        ChoosePlanPurchaseEvent(productDetails: productDetails),
      );
    }

    return BlocBuilder<PurchaseBloc, PurchaseState>(
      builder: (context, state) {
        if (state.plansNonRenewSub.isEmpty) {
          return SizedBox.shrink();
        }
        return Column(
          children: [
            Text(
              'Choose Your Plan Non Renew Sub',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            ListView.builder(
              itemExtent: 128,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.plansNonRenewSub.length,
              itemBuilder: (context, index) {
                final isActive =
                    state.plansNonRenewSub[index].id ==
                    state.selectedProductDetail?.id;

                return AnimatedScale(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  scale: isActive ? 1 : 0.97,
                  child: AnimatedContainer(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.white.withValues(alpha: 0.55)
                          : Colors.white.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isActive ? Colors.white : Colors.transparent,
                        width: isActive ? 2 : 1,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: isActive ? 0.25 : 0.08,
                          ),
                          blurRadius: isActive ? 16 : 4,
                          offset: Offset(0, isActive ? 8 : 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => handleChoosePlan(
                          productDetails: state.plansNonRenewSub[index],
                        ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.plansNonRenewSub[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(state.plansNonRenewSub[index].price),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.plansNonRenewSub[index].description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8),
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
