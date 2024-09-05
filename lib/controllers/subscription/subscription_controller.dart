
import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:intl/intl.dart';

import '../../services/Firebase/firebase _authentication.dart';
import '../../utils/core/app_constants.dart';
import '../../utils/core/app_enums.dart';
import '../../utils/network/DataSource.dart';
import '../../utils/subscription/consumableStore.dart';
import '../connection/connection_manager_controller.dart';



class SubscriptionController extends GetxController {
  DataSourceClass? dataSourceSuperApp;

  SubscriptionController({this.dataSourceSuperApp});

  final ConnectionManagerController connController =
  Get.find<ConnectionManagerController>();

  List<SubscriptionPlans> planList = [SubscriptionPlans.MONTHLY,SubscriptionPlans.YEARLY].obs;
  List<String> planPremiumList = ["19.99","199.99","239.99"];
  RxString selectedPlan = SubscriptionPlansEnum.getPlanInString(SubscriptionPlans.MONTHLY).obs;
  final AuthServices _authServices = AuthServices();

  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  // Rx<InAppPurchase> inAppPurchase = InAppPurchase.instance.obs;
  late StreamSubscription<List<PurchaseDetails>> subscription;
  // StreamSubscription<List<PurchaseDetails>>? subscription;
  final messangerKey = GlobalKey<ScaffoldMessengerState>();
  RxList<String> notFoundIds = <String>[].obs;
  RxList<ProductDetails> products = <ProductDetails>[].obs;
  RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;
  // final Map<String, PurchaseDetails> purchasesData = Map<String, PurchaseDetails>[];
  RxMap<String, PurchaseDetails> purchasesData = RxMap();
  RxList<String> consumables = <String>[].obs;
  RxBool isAvailable = false.obs;
  RxBool _purchasePending = false.obs;
  RxBool loading = true.obs;
  RxString queryProductError = "".obs;

  @override
  void onInit() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchase.purchaseStream;
    subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          subscription?.cancel();
        }, onError: (Object error) {
          // handle error here.
        });
    initStoreInfo();
    super.onInit();
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    subscription?.cancel();
    super.dispose();
  }

  selectedPlanClicked(int index){
    // genderSelectedIndex.value = index;
    selectedPlan.value = SubscriptionPlansEnum.getPlanInString(planList[index]);
    print("selectedPlan "+SubscriptionPlansEnum.getPlanInString(planList[index]));
  }

  Future<void> initStoreInfo() async {
    print("initStoreInfo ");
    final bool IsAvailable = await inAppPurchase.isAvailable();
    if (!IsAvailable) {
        isAvailable.value = IsAvailable;
        products.value = <ProductDetails>[];
        purchases.value = <PurchaseDetails>[];
        notFoundIds.value = <String>[];
        consumables.value = <String>[];
        _purchasePending.value = false;
        loading.value = false;
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
    await inAppPurchase.queryProductDetails(kProductIds.toSet());
    if (productDetailResponse.error != null) {
        queryProductError.value= productDetailResponse.error!.message;
        isAvailable.value = IsAvailable;
        products.value = productDetailResponse.productDetails;
        purchases.value = <PurchaseDetails>[];
        notFoundIds.value = productDetailResponse.notFoundIDs;
        consumables.value = <String>[];
        _purchasePending.value = false;
        loading.value = false;
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
        queryProductError.value = "";
        isAvailable.value = IsAvailable;
        products.value = productDetailResponse.productDetails;
        purchases.value = <PurchaseDetails>[];
        notFoundIds.value = productDetailResponse.notFoundIDs;
        consumables.value = <String>[];
        _purchasePending.value = false;
        loading.value = false;
      return;
    }

    final List<String> consumablesArr = await ConsumableStore.load();
      isAvailable.value = IsAvailable;
      products.value = productDetailResponse.productDetails;
      notFoundIds.value = productDetailResponse.notFoundIDs;
      consumables.value = consumablesArr;
      _purchasePending.value = false;
      loading.value = false;
  }

  void restoreStoreInfo(){
    inAppPurchase.restorePurchases();
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumablesArr = await ConsumableStore.load();
      consumables.value = consumablesArr;
  }

  void showPendingUI() {
      _purchasePending.value = true;
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    print("deliverProduct");
    print(purchaseDetails.productID);
    print(kConsumableId);
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumablesArr = await ConsumableStore.load();
        _purchasePending.value = false;
        consumables.value = consumablesArr;
    } else {
        purchases.value.add(purchaseDetails);
        _purchasePending.value = false;
    }
    print("purchases array Count "+purchases.value.length.toString());
    // await inAppPurchase.restorePurchases();
    getSubscriptionProductsList();
  }

  void handleError(IAPError error) {
    print("handleError");
      _purchasePending.value = false;
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    print("_verifyPurchase");
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
    print("_handleInvalidPurchase");
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      print("purchaseDetails.status "+purchaseDetails.status.toString());
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("if _listenToPurchaseUpdated");
        showPendingUI();
      } else {
        print("else _listenToPurchaseUpdated");
        if (purchaseDetails.status == PurchaseStatus.error || purchaseDetails.status == PurchaseStatus.canceled) {
          handleError(purchaseDetails.error!);
          messangerKey.currentState?.showSnackBar(SnackBar(content: Text("Error Occured")));
          return;
        }else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            unawaited(deliverProduct(purchaseDetails));
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        // print somethings in below if else
        if (Platform.isAndroid) {
          if (!kAutoConsume && purchaseDetails.productID == kConsumableId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
            inAppPurchase.getPlatformAddition<
                InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    // Price changes for Android are not handled by the application, but are
    // instead handled by the Play Store. See
    // https://developer.android.com/google/play/billing/price-changes for more
    // information on price changes on Android.
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
      inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }

  GooglePlayPurchaseDetails? getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription;
    if (productDetails.id == kSilverSubscriptionId &&
        purchases[kGoldSubscriptionId] != null) {
      oldSubscription =
      purchases[kGoldSubscriptionId]! as GooglePlayPurchaseDetails;
    } else if (productDetails.id == kGoldSubscriptionId &&
        purchases[kSilverSubscriptionId] != null) {
      oldSubscription =
      purchases[kSilverSubscriptionId]! as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }

  void getSubscriptionProductsList(){
    purchasesData.value = Map<String, PurchaseDetails>.fromEntries(
        purchases.value.map((PurchaseDetails purchase) {
          if (purchase.pendingCompletePurchase) {
            inAppPurchase.completePurchase(purchase);
          }
          return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
        }));
    print("purchases INTO "+purchases.value.toString());
    print("purchases INTO Array Count "+purchases.value.length.toString());
    print("purchasesData INTO Array Count "+purchasesData.value.length.toString());
    for (ProductDetails productDetails in products.value){

      print("productDetails id "+productDetails.id);
      print("productDetails title "+productDetails.title);
      print("productDetails description "+productDetails.description);
      print("productDetails currencyCode "+productDetails.currencyCode);
      print("productDetails currencySymbol "+productDetails.currencySymbol);
      print("productDetails price "+productDetails.price);

      final PurchaseDetails? previousPurchase = purchasesData.value[productDetails.id];

      String purchaseID = previousPurchase?.purchaseID ?? "default purchaseID";
      print("previousPurchase purchaseID "+purchaseID);

      String productID = previousPurchase?.productID ?? 'default productID';
      print("previousPurchase purchaseID "+productID);

      String transactionDate = previousPurchase?.transactionDate ?? "";
      print("previousPurchase transactionDate "+transactionDate);

      if (previousPurchase?.transactionDate != null && transactionDate != "") {
        var date = new DateTime.fromMicrosecondsSinceEpoch(int.parse(transactionDate)*1000);
        var dateStr = DateFormat('MM/dd/yyyy, hh:mm a').format(date);
        print("previousPurchase transactionDate String "+dateStr);
      }

      String localVerificationData = previousPurchase?.verificationData.localVerificationData ?? 'default localVerificationData';
      print("previousPurchase localVerificationData "+localVerificationData);

      String serverVerificationData = previousPurchase?.verificationData.serverVerificationData ?? 'default serverVerificationData';
      print("previousPurchase serverVerificationData "+serverVerificationData);

      String source = previousPurchase?.verificationData.source ?? 'default source';
      print("previousPurchase source "+source);

      String statusName = previousPurchase?.status.name ?? 'default statusName';
      print("previousPurchase statusName "+statusName);

      String errordetails = previousPurchase?.error?.details.toString() ?? 'default errordetails';
      print("previousPurchase errordetails "+errordetails);

      String pendingCompletePurchase = previousPurchase?.pendingCompletePurchase.toString() ?? 'default transactionDate';
      print("previousPurchase pendingCompletePurchase "+pendingCompletePurchase);

    }
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
