import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final InAppPurchase _iap = InAppPurchase.instance;

  final Set<String> _productConsumableIds = <String>{
    "com.example.batterylevel.premium",
    "com.example.batterylevel.plus",
  };

  final Set<String> _productNonConsumableIds = <String>{
    "com.example.batterylevel.family",
    "com.example.batterylevel.personal",
  };

  final Set<String> _productNonRenewSubIds = <String>{
    "com.example.batterylevel.plus_non_renew_sub",
    "com.example.batterylevel.premium_non_renew_sub",
  };

  final Set<String> _productAutoRenewSubIds = <String>{
    "com.example.batterylevel.plus_auto_renew_sub",
    "com.example.batterylevel.premium_auto_renew_sub",
  };

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  PurchaseBloc() : super(PurchaseState()) {
    on<ChoosePlanPurchaseEvent>(_choosePlan);
    on<SubmitPurchaseEvent>(_submit);
    on<SubmitProductConsumablePurchaseEvent>(_submitConsumable);
    on<SubmitProductNonConsumablePurchaseEvent>(_submitNonConsumable);
    on<SubmitProductNonRenewSubPurchaseEvent>(_submitNonRenewSub);
    on<SubmitProductAutoRenewSubPurchaseEvent>(_submitAutoRenewSub);
    on<CancelPurchaseEvent>(_cancelPlan);
    on<LoadProductConsumerPurchaseEvent>(_loadProductConsumable);
    on<LoadProductNonConsumerPurchaseEvent>(_loadProductNonConsumable);
    on<LoadProductNonRenewSubPurchaseEvent>(_loadProductNonRenewSub);
    on<LoadProductAutoRenewSubPurchaseEvent>(_loadProductAutoRenewSub);
    on<ShowOfferCodeSheetEvent>(_showOfferCodeSheet);

    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;

    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription?.cancel();
      },
      onError: (error) {},
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("Đang chờ thanh toán...");
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print("Lỗi thanh toán: ${purchaseDetails.error}");
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          print("THANH TOÁN THÀNH CÔNG! Giao hàng cho user ở đây.");
        }

        if (purchaseDetails.pendingCompletePurchase) {
          try {
            await _iap.completePurchase(purchaseDetails);
            print("Đã đóng giao dịch an toàn.");
          } catch (e) {
            print("Bỏ qua lỗi đóng giao dịch ảo trên Simulator: $e");
          }
        }
      }
    }
  }

  void _choosePlan(ChoosePlanPurchaseEvent event, Emitter<PurchaseState> emit) {
    emit(state.copyWith(selectedProductDetail: event.productDetails));
  }

  void _submit(SubmitPurchaseEvent event, Emitter<PurchaseState> emit) async {
    if (state.selectedProductDetail == null) {
      return;
    }
    bool isConsumable = _productConsumableIds.contains(state.selectedProductDetail!.id);
    bool isNonConsumable = _productNonConsumableIds.contains(state.selectedProductDetail!.id);
    bool isNonRenewSub = _productNonRenewSubIds.contains(state.selectedProductDetail!.id);
    bool isAutoRenewSub = _productAutoRenewSubIds.contains(state.selectedProductDetail!.id);

    if (isConsumable) {
      add(SubmitProductConsumablePurchaseEvent());
    } else if (isNonConsumable) {
      add(SubmitProductNonConsumablePurchaseEvent());
    } else if (isNonRenewSub) {
      add(SubmitProductNonRenewSubPurchaseEvent());
    } else if (isAutoRenewSub) {
      add(SubmitProductAutoRenewSubPurchaseEvent());
    }
  }

  void _submitConsumable(SubmitProductConsumablePurchaseEvent event, Emitter<PurchaseState> emit) async {
    if (state.selectedProductDetail == null) {
      return;
    }
    try {
      await _iap.buyConsumable(
        purchaseParam: PurchaseParam(productDetails: state.selectedProductDetail!),
        autoConsume: true,
      );
    } catch (e) {
      print("error: $e");
    }
  }

  void _submitNonConsumable(SubmitProductNonConsumablePurchaseEvent event, Emitter<PurchaseState> emit) async {
    if (state.selectedProductDetail == null) {
      return;
    }
    try {
      await _iap.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: state.selectedProductDetail!));
    } catch (e) {
      print("error: $e");
    }
  }

  void _submitNonRenewSub(SubmitProductNonRenewSubPurchaseEvent event, Emitter<PurchaseState> emit) async {
    if (state.selectedProductDetail == null) {
      return;
    }
    try {
      await _iap.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: state.selectedProductDetail!));
    } catch (e) {
      print("error: $e");
    }
  }

  void _submitAutoRenewSub(SubmitProductAutoRenewSubPurchaseEvent event, Emitter<PurchaseState> emit) async {
    if (state.selectedProductDetail == null) {
      return;
    }
    try {
      await _iap.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: state.selectedProductDetail!));
    } catch (e) {
      print("error: $e");
    }
  }

  void _loadProductConsumable(LoadProductConsumerPurchaseEvent event, Emitter<PurchaseState> emit) async {
    emit(state.copyWith(status: PurchaseProductStatus.loading));
    print("_loadProductConsumable");
    final bool isAvailable = await _iap.isAvailable();
    print("isAvailable: $isAvailable");
    if (!isAvailable) {
      emit(state.copyWith(status: PurchaseProductStatus.failure, messageError: "IAP is not available"));
      return;
    }
    try {
      final ProductDetailsResponse response = await _iap.queryProductDetails(_productConsumableIds);
      print("response.productDetails:  ${response.productDetails.length}");
      if (response.productDetails.isEmpty) {
        emit(state.copyWith(status: PurchaseProductStatus.failure, messageError: "Products is empty"));
        return;
      }
      emit(state.copyWith(status: PurchaseProductStatus.success, plansConsumable: response.productDetails));
    } catch (e) {
      print("error: $e");
      emit(state.copyWith(status: PurchaseProductStatus.failure));
    }
  }

  void _loadProductNonConsumable(LoadProductNonConsumerPurchaseEvent event, Emitter<PurchaseState> emit) async {
    emit(state.copyWith(status: PurchaseProductStatus.loading));
    print("_loadProductNonConsumable");
    final bool isAvailable = await _iap.isAvailable();
    print("isAvailable: $isAvailable");
    if (!isAvailable) {
      emit(state.copyWith(status: PurchaseProductStatus.failure, messageError: "IAP is not available"));
      return;
    }
    try {
      final ProductDetailsResponse response = await _iap.queryProductDetails(_productNonConsumableIds);
      print("response.productDetails:  ${response.productDetails.length}");
      if (response.productDetails.isEmpty) {
        emit(state.copyWith(status: PurchaseProductStatus.failure, messageError: "Products is empty"));
        return;
      }
      emit(state.copyWith(status: PurchaseProductStatus.success, plansNonConsumable: response.productDetails));
    } catch (e) {
      print("error: $e");
      emit(state.copyWith(status: PurchaseProductStatus.failure));
    }
  }

  void _loadProductNonRenewSub(LoadProductNonRenewSubPurchaseEvent event, Emitter<PurchaseState> emit) async {
    emit(state.copyWith(status: PurchaseProductStatus.loading));
    print("_loadProductNonRenewSub");
    final bool isAvailable = await _iap.isAvailable();
    print("isAvailable: $isAvailable");
    if (!isAvailable) {
      emit(state.copyWith(status: PurchaseProductStatus.failure, messageError: "IAP is not available"));
      return;
    }
    try {
      final ProductDetailsResponse response = await _iap.queryProductDetails(_productNonRenewSubIds);
      print("response.productDetails:  ${response.productDetails.length}");
      if (response.productDetails.isEmpty) {
        emit(state.copyWith(status: PurchaseProductStatus.failure, messageError: "Products is empty"));
        return;
      }
      emit(state.copyWith(status: PurchaseProductStatus.success, plansNonRenewSub: response.productDetails));
    } catch (e) {
      print("error: $e");
      emit(state.copyWith(status: PurchaseProductStatus.failure));
    }
  }

  void _loadProductAutoRenewSub(LoadProductAutoRenewSubPurchaseEvent event, Emitter<PurchaseState> emit) async {
    emit(state.copyWith(status: PurchaseProductStatus.loading));
    print("_loadProductAutoRenewSub");
    final bool isAvailable = await _iap.isAvailable();
    print("isAvailable: $isAvailable");
    if (!isAvailable) {
      emit(state.copyWith(status: PurchaseProductStatus.failure, messageError: "IAP is not available"));
      return;
    }
    try {
      final ProductDetailsResponse response = await _iap.queryProductDetails(_productAutoRenewSubIds);
      print("response.productDetails:  ${response.productDetails.length}");
      if (response.productDetails.isEmpty) {
        emit(state.copyWith(status: PurchaseProductStatus.failure, messageError: "Products is empty"));
        return;
      }
      emit(state.copyWith(status: PurchaseProductStatus.success, plansAutoRenewSub: response.productDetails));
    } catch (e) {
      print("error: $e");
      emit(state.copyWith(status: PurchaseProductStatus.failure));
    }
  }

  void _showOfferCodeSheet(ShowOfferCodeSheetEvent event, Emitter<PurchaseState> emit) async {
    try {
      if (Platform.isIOS) {
        final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = _iap
            .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();

        await iosPlatformAddition.presentCodeRedemptionSheet();
        print("Đã mở bảng nhập mã thành công!");
      } else {
        print("Tính năng nhập mã Offer Code chỉ hỗ trợ trên hệ điều hành iOS.");
      }
    } catch (e) {
      print("Lỗi khi mở bảng nhập mã: $e");
    }
  }

  void _cancelPlan(CancelPurchaseEvent event, Emitter<PurchaseState> emit) {}
}
