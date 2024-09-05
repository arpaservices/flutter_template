
import 'dart:async';
import 'dart:io';

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../services/extra/billing.dart';
import '../../utils/core/app_enums.dart';
import '../../utils/core/app_strings.dart';
import '../../utils/network/DataSource.dart';
import '../connection/connection_manager_controller.dart';


class AppSubscriptionController extends GetxController {
  DataSourceClass? dataSourceSuperApp;

  AppSubscriptionController({this.dataSourceSuperApp});

  final ConnectionManagerController connController =
  Get.find<ConnectionManagerController>();

  List<SubscriptionPlans> planList = [SubscriptionPlans.MONTHLY,SubscriptionPlans.YEARLY].obs;
  List<String> planPremiumList = ["19.99","199.99","239.99"];
  RxString selectedPlan = SubscriptionPlansEnum.getPlanInString(SubscriptionPlans.MONTHLY).obs;

  late dynamic _purchaseUpdatedSubscription;
  late dynamic _purchaseErrorSubscription;
  late dynamic _connectionSubscription;

  RxString state = "".obs;

  // final List<String> _productLists = Platform.isAndroid
  //     ? [
  //   'android.test.purchased',
  //   'point_1000',
  //   '5000_point',
  //   'android.test.canceled',
  // ]
  //     : ['ap_1999_1mo', 'ap_19999_1yr'];

  // final List<String> _productLists = Platform.isAndroid
  //     ? ['com.absaly.app.dev.android_monthly', 'com.absaly.app.dev.android_yearly']
  //     : ['com.absaly.app.dev.monthly_subs', 'com.absaly.app.dev.yearly_subscription'];



  final List<String> _productLists = Platform.isAndroid
      // ? ['absaly-19-1mo', 'absaly-19-1yr']
      ? ['absaly_demo_subscription']
      : ['absaly_999_1mo', 'ap_19999_1yr'];

  RxList<IAPItem> itemsArr = <IAPItem>[].obs;
  RxList<PurchasedItem> purchasesArr = <PurchasedItem>[].obs;
  Rx<IAPItem> selectedItem = IAPItem.fromJSON({}).obs;

  int updateCounter = 1;

  final BillingService _billingService = BillingService();

  @override
  void onInit() {
    print("onInit AppSubscriptionController");
    initPlatformState();
    // _billingService.initialize();
    // _billingService.listenToPurchaseUpdates();
    super.onInit();
  }

  @override
  void dispose() {
    print("dispose AppSubscriptionController");
    if (_connectionSubscription != null) {
      _connectionSubscription.cancel();
      _connectionSubscription = null;
    }
    super.dispose();
  }

  selectedPlanClicked(int index){
    // genderSelectedIndex.value = index;
    // selectedPlan.value = SubscriptionEnum.getPlan(planList[index]);
    // print("selectedPlan "+SubscriptionEnum.getPlan(planList[index]));
    IAPItem subscriptionItem = itemsArr.value[index];
    String subscriptionStr = subscriptionItem.description ?? "";
    selectedPlan.value = SubscriptionPlansEnum.getPlanInString(SubscriptionPlansEnum.getPlanInEnum(subscriptionStr));
    print("selectedPlan "+SubscriptionPlansEnum.getPlanInString(SubscriptionPlansEnum.getPlanInEnum(subscriptionStr)));
  }

  purchaseFunction() async {
    await _billingService.fetchSubscriptions();
    final ProductDetails product =ProductDetails(id: "absaly-19-1mo", title: "title", description: "description", price: "23", rawPrice: 20, currencyCode: "IN");
    await _billingService.purchaseSubscription(product);
  }

  Future<void> initPlatformState() async {
    // prepare
    var result = await FlutterInappPurchase.instance.initialize();
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAll();
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _connectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
          print('connected: $connected');
        });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
          print('purchase-updated: $productItem');
          updateCounter = updateCounter+1;
          if (updateCounter == 1){
            print("purchase-updated initializePurchase");
            getPurchases();
          }
        });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
          print('purchase-error: $purchaseError');
        });

    print("initializePurchase");
    initializePurchase();
  }

  void initializePurchase() async{
    state.value = States.LOADING;
    updateCounter = 0;
    await getProduct();
    await getPurchases();
    // state.value = States.SUCCESS;
    /*
    Future.delayed(Duration(milliseconds: 2000), () async {
      updateCounter = 0;
      await getProduct();
      await getPurchases();
      // await getPurchaseHistory();
      state.value = States.SUCCESS;
      // selectedPlanClicked(0);
    });
    */
  }

  Future getProduct() async {
    print("getProduct called");
    List<IAPItem> items =
    await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in items) {
      print("getProduct item.productId "+item.productId.toString());
      print("getProduct item.title "+item.title.toString());
      print("getProduct item.description "+item.description.toString());
      print("getProduct item.subscriptionPeriodUnitIOS "+item.subscriptionPeriodUnitIOS.toString());
      print("getProduct item.localizedPrice "+item.localizedPrice.toString());
      // itemsArr.value.add(item);
    }
    itemsArr.value = items;
    print("itemsArr count "+itemsArr.value.length.toString());
  }

  Future getPurchases() async {
    purchasesArr.clear();
    print("getPurchases called");
    List<PurchasedItem>? items =
    await FlutterInappPurchase.instance.getAvailablePurchases();
    state.value = States.SUCCESS;
    for (var item in items!) {
      print("getPurchases item.productId "+item.productId.toString());
      print("getPurchases productLists.contains(item.productId) "+_productLists.contains(item.productId).toString());
      print("getPurchases item.transactionStateIOS "+item.transactionStateIOS.toString());
      print("getPurchases item.transactionDate "+item.transactionDate.toString());
      print("getPurchases item.originalTransactionDateIOS "+item.originalTransactionDateIOS.toString());
      print("getPurchases item.originalTransactionIdentifierIOS "+item.originalTransactionIdentifierIOS.toString());
      if (item.productId != null && _productLists.contains(item.productId) && (item.transactionStateIOS == TransactionState.purchased || item.transactionStateIOS == TransactionState.restored)){
        // print("getPurchases item.productId "+item.productId.toString());
        // print("getPurchases productLists.contains(item.productId) "+_productLists.contains(item.productId).toString());
        // print("getPurchases item.transactionStateIOS "+item.transactionStateIOS.toString());
        purchasesArr.value.add(item);
      }
    }
    print("purchasesArr count before "+purchasesArr.value.length.toString());
    var seen = Set<String>();
    purchasesArr.value = purchasesArr.value.where((item) => seen.add(item.productId!)).toList();
    print("purchasesArr count after "+purchasesArr.value.length.toString());
    if (purchasesArr.value.length > 0) {
      for (var newItem in itemsArr.value) {
        if (newItem.productId!.toLowerCase() == purchasesArr.value[0].productId!){
          selectedItem.value = newItem;
        }
      }
    }
  }

  Future getPurchaseHistory() async {
    print("getPurchaseHistory called");
    List<PurchasedItem>? items =
    await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in items!) {
      // print("getPurchases item.productId "+item.productId.toString());
      // print("getPurchases productLists.contains(item.productId) "+_productLists.contains(item.productId).toString());
      // print("getPurchases item.transactionStateIOS "+item.transactionStateIOS.toString());
      // print("getPurchases item.transactionDate "+item.transactionDate.toString());
      // print("getPurchases item.originalTransactionDateIOS "+item.originalTransactionDateIOS.toString());
      // print("getPurchases item.originalTransactionIdentifierIOS "+item.originalTransactionIdentifierIOS.toString());
      if (item.productId != null && _productLists.contains(item.productId) && (item.transactionStateIOS == TransactionState.purchased || item.transactionStateIOS == TransactionState.restored)){
        print("getPurchases item.productId "+item.productId.toString());
        print("getPurchases productLists.contains(item.productId) "+_productLists.contains(item.productId).toString());
        print("getPurchases item.transactionStateIOS "+item.transactionStateIOS.toString());
        purchasesArr.value.add(item);
      }
    }
    purchasesArr.value = items;
    print("purchasesArr count "+purchasesArr.value.length.toString());
  }

  int getSubsPlanIndex(String plan){
    if (itemsArr.value.length > 0 ){
      int index = itemsArr.value.indexWhere((item) {
        String itemDesc = item.description ?? "";
        return itemDesc.toLowerCase() == plan.toLowerCase();
      });
      return index;
    }
    return 0;
  }

  String getSubsPlanID(int index){
    if (itemsArr.value.length > 0 && itemsArr.value[index] != null){
      IAPItem subscriptionItem = itemsArr.value[index];
      return subscriptionItem.productId ?? "";
    }
    return "";
  }

  String getSubsPlanDesc(int index){
    if (itemsArr.value.length > 0 && itemsArr.value[index] != null){
      IAPItem subscriptionItem = itemsArr.value[index];
      return subscriptionItem.description ?? "";
    }
    return "";
  }

  String getSubsPlanTitle(int index){
    if (itemsArr.value.length > 0 && itemsArr.value[index] != null){
      IAPItem subscriptionItem = itemsArr.value[index];
      return subscriptionItem.title ?? "";
    }
    return "";
  }

  String getSubsPlanPrice(int index){
    if (itemsArr.value.length > 0 && itemsArr.value[index] != null){
      IAPItem subscriptionItem = itemsArr.value[index];
      return subscriptionItem.localizedPrice ?? "";
    }
    return "";
  }

  IAPItem? getSelectedSubsPlan(int index){
    if (itemsArr.value.length > 0 && itemsArr.value[index] != null){
      return itemsArr.value[index];
    }
    return null;
  }

  purchasePackage(){
    print("purchasePackage");
    print("getSubsPlanIndex "+getSubsPlanIndex(selectedPlan.value).toString());
    print("selectedPlan.value "+selectedPlan.value);
    IAPItem? selectedItem = getSelectedSubsPlan(getSubsPlanIndex(selectedPlan.value));
    if (selectedItem != null){
      print("selectedItem.productId "+selectedItem.productId!);
      updateCounter = 0;
      FlutterInappPurchase.instance.requestPurchase(selectedItem.productId!);
    }
  }

  purchaseMonthlyPackage(){

  }

  purchaseYearlyPackage(){

  }

}