part of 'purchase_bloc.dart';

enum PurchaseProductStatus { initial, loading, success, failure }

class PurchaseState {
  String messageError = '';
  ProductDetails? selectedProductDetail;
  List<ProductDetails> plansConsumable = [];
  List<ProductDetails> plansNonConsumable = [];
  List<ProductDetails> plansNonRenewSub = [];
  List<ProductDetails> plansAutoRenewSub = [];
  PurchaseProductStatus status = PurchaseProductStatus.initial;
  PurchaseState();

  PurchaseState copyWith({
    List<ProductDetails>? plansConsumable,
    List<ProductDetails>? plansNonConsumable,
    List<ProductDetails>? plansNonRenewSub,
    List<ProductDetails>? plansAutoRenewSub,

    ProductDetails? selectedProductDetail,
    PurchaseProductStatus? status,
    String? messageError,
  }) {
    return PurchaseState()
      ..status = status ?? this.status
      ..messageError = messageError ?? this.messageError
      ..plansConsumable = plansConsumable ?? this.plansConsumable
      ..plansNonRenewSub = plansNonRenewSub ?? this.plansNonRenewSub
      ..plansAutoRenewSub = plansAutoRenewSub ?? this.plansAutoRenewSub
      ..plansNonConsumable = plansNonConsumable ?? this.plansNonConsumable
      ..selectedProductDetail =
          selectedProductDetail ?? this.selectedProductDetail;
  }
}
