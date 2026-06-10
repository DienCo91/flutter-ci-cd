part of 'purchase_bloc.dart';

sealed class PurchaseEvent {}

class ChoosePlanPurchaseEvent extends PurchaseEvent {
  final ProductDetails? productDetails;
  ChoosePlanPurchaseEvent({required this.productDetails});
}

class SubmitPurchaseEvent extends PurchaseEvent {}

class SubmitProductConsumablePurchaseEvent extends PurchaseEvent {}

class SubmitProductNonConsumablePurchaseEvent extends PurchaseEvent {}

class SubmitProductNonRenewSubPurchaseEvent extends PurchaseEvent {}

class SubmitProductAutoRenewSubPurchaseEvent extends PurchaseEvent {}

class LoadProductConsumerPurchaseEvent extends PurchaseEvent {}

class LoadProductNonConsumerPurchaseEvent extends PurchaseEvent {}

class LoadProductNonRenewSubPurchaseEvent extends PurchaseEvent {}

class LoadProductAutoRenewSubPurchaseEvent extends PurchaseEvent {}

class ShowOfferCodeSheetEvent extends PurchaseEvent {}

class CancelPurchaseEvent extends PurchaseEvent {
  final ProductDetails? productDetails;
  CancelPurchaseEvent({required this.productDetails});
}
