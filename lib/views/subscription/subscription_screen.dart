
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:intl/intl.dart';

import '../../controllers/subscription/subscription_controller.dart';
import '../../utils/core/app_colors.dart';
import '../../utils/core/app_constants.dart';
import '../../utils/core/app_strings.dart';
import '../../utils/supportUi/deviceInfo.dart';
import '../../utils/supportUi/widget_function.dart';

class SubscriptionScreen extends GetView<SubscriptionController> {


  @override
  void dispose() {

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: primary_bg,
        //   leading: BackButton(
        //       color: dark
        //   ),
        //   title: getNewFontText("Settings", TextAlign.center, dark, FontWeight.w500, 25),
        // ),
        body: SafeArea(
            child: Obx(() => Expanded(
              child: Container(
                height: DeviceInfo.deviceHeight()*0.95,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          addVerticalSpace(20),
                          getPPHattonText(
                              AppTitles.Upgrade_Plan, TextAlign.center, dark,
                              FontWeight.w600, 35),
                          addVerticalSpace(20),
                          (controller.loading.value) ? Card(
                              child: ListTile(
                                  leading: CircularProgressIndicator(),
                                  title: Text('Fetching products...'))
                          ) : (!controller.isAvailable.value) ? Card() : buildProductList(context),
                          buildRestoreButton(context),
                          /*
                          Padding(padding: EdgeInsets.all(10),child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              addHorizontalSpace(DeviceInfo.deviceWidth()*0.12),
                              InkWell(
                                onTap: (){
                                  controller.selectedPlanClicked(0);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: darkGrey, width: 2),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: (controller.selectedPlan.value == SubscriptionEnum.getPlan(Subscription.monthly)) ? primary : settingSeperator
                                    ),
                                    height: 40,
                                    width: DeviceInfo.deviceWidth()*0.33,
                                    child: Center(child: Text(
                                      SubscriptionEnum.getPlan(Subscription.monthly),
                                      style: const TextStyle(
                                          color: dark,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),)
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  controller.selectedPlanClicked(1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    // border: Border.all(color: darkGrey, width: 2),
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: (controller.selectedPlan.value == SubscriptionEnum.getPlan(Subscription.yearly)) ? primary : settingSeperator
                                  ),
                                  height: 40,
                                  width: DeviceInfo.deviceWidth()*0.33,
                                  child: Center(child: Text(
                                    SubscriptionEnum.getPlan(Subscription.yearly),
                                    style: const TextStyle(
                                        color: dark,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),),
                                ),
                              ),
                              addHorizontalSpace(DeviceInfo.deviceWidth()*0.12),
                            ],
                          ),),
                          */
                          addVerticalSpace(30),
                          /*
                          Container(
                            width: DeviceInfo.deviceWidth()*0.85,
                            color: primary_bg.withOpacity(0.15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                addVerticalSpace(20),
                                getNewFontText(
                                    AppTitles.Absaly_Premium, TextAlign.center, dark,
                                    FontWeight.w500, 25),
                                addVerticalSpace(20),
                                (controller.selectedPlan.value == SubscriptionEnum.getPlan(Subscription.yearly)) ? Container(child: Text("\u0024 " + controller.planPremiumList[2] + "/yr", style: TextStyle(fontFamily: "PP Hatton",
                                    decoration: TextDecoration.lineThrough, color: darkGrey, fontWeight: FontWeight.w700, fontSize: 40),),) : Container(),
                                getNewFontText(
                                    (controller.selectedPlan.value == SubscriptionEnum.getPlan(Subscription.monthly)) ? "\u0024 " + controller.planPremiumList[0] + "/mo" : "\u0024 " + controller.planPremiumList[1] + "/yr", TextAlign.center, dark,
                                    FontWeight.w700, 35),
                                Container(margin: EdgeInsets.symmetric(horizontal: 10),child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    addVerticalSpace(10),
                                    addBulletString(AppTitles.Plan_Premium_title1,dark,18),
                                    addVerticalSpace(5),
                                    addBulletString(AppTitles.Plan_Premium_title2,dark,18),
                                    addVerticalSpace(5),
                                    addBulletString(AppTitles.Plan_Premium_title3,dark,18),
                                    addVerticalSpace(5),
                                    addBulletString(AppTitles.Plan_Premium_title4,dark,18),
                                    addVerticalSpace(5),
                                    addBulletString(AppTitles.Plan_Premium_title5,dark,18),
                                    addVerticalSpace(10),
                                  ],
                                ),),
                                addVerticalSpace(10)
                              ],
                            ),
                          ),
                          */
                        ],
                      ),
                      addVerticalSpace(DeviceInfo.deviceHeight()*0.12),
                      Column(
                        children: [
                          SizedBox(
                            width: DeviceInfo.deviceWidth()*0.8,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {

                              },
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(
                                    Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    primary),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: dark
                                  ),
                                ),
                              ),
                            ),),
                          addVerticalSpace(10),
                          SizedBox(
                            width: DeviceInfo.deviceWidth()*0.5,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(
                                    Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    primary),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                              // style: ButtonStyle(
                              // foregroundColor: MaterialStateProperty.all<Color>(
                              //     Colors.white),
                              // backgroundColor: MaterialStateProperty.all<Color>(
                              //     Colors.white),
                              //   shape: MaterialStateProperty.all<
                              //       RoundedRectangleBorder>(
                              //     RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(24.0),
                              //     ),
                              //   ),
                              // ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "NO THANKS",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: dark
                                  ),
                                ),
                              ),
                            ),
                          ),
                          addVerticalSpace(20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ))),
      ),
    );
  }

  Card buildProductList(BuildContext context) {
    // if (controller.loading.value) {
    //   return const Card(
    //       child: ListTile(
    //           leading: CircularProgressIndicator(),
    //           title: Text('Fetching products...')));
    // }
    // if (!controller.isAvailable.value) {
    //   return const Card();
    // }
    // const ListTile productHeader = ListTile(title: Text('Products for Sale'));
    final List<ListTile> productList = <ListTile>[];
    // if (controller.notFoundIds.value.isNotEmpty) {
    //   productList.add(ListTile(
    //       title: Text('[${controller.notFoundIds.join(", ")}] not found',
    //           style: TextStyle(color: ThemeData.light().colorScheme.error)),
    //       subtitle: const Text(
    //           'This app needs special configuration to run. Please see example/README.md for instructions.')));
    // }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    // final Map<String, PurchaseDetails> purchases =
    // Map<String, PurchaseDetails>.fromEntries(
    //     controller.purchases.value.map((PurchaseDetails purchase) {
    //       if (purchase.pendingCompletePurchase) {
    //         controller.inAppPurchase.completePurchase(purchase);
    //       }
    //       return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    //     }));
    // print("purchases INTO "+purchases.toString());
    productList.addAll(controller.products.value.map(
          (ProductDetails productDetails) {
        print("productDetails id "+productDetails.id);
        print("productDetails title "+productDetails.title);
        print("productDetails description "+productDetails.description);
        print("productDetails currencyCode "+productDetails.currencyCode);
        print("productDetails currencySymbol "+productDetails.currencySymbol);
        print("productDetails price "+productDetails.price);

        final PurchaseDetails? previousPurchase = controller.purchasesData.value[productDetails.id];

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

        return ListTile(
          title: Text(
            productDetails.title,
          ),
          subtitle: Text(
            productDetails.description,
          ),
          trailing: previousPurchase != null && Platform.isIOS
              ? IconButton(
              onPressed: () => controller.confirmPriceChange(context),
              icon: const Icon(Icons.upgrade))
              : TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green[800],
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              late PurchaseParam purchaseParam;

              if (Platform.isAndroid) {
                // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                // verify the latest status of you your subscription by using server side receipt validation
                // and update the UI accordingly. The subscription purchase status shown
                // inside the app may not be accurate.
                final GooglePlayPurchaseDetails? oldSubscription =
                controller.getOldSubscription(productDetails, controller.purchasesData.value);

                purchaseParam = GooglePlayPurchaseParam(
                    productDetails: productDetails,
                    changeSubscriptionParam: (oldSubscription != null)
                        ? ChangeSubscriptionParam(
                      oldPurchaseDetails: oldSubscription,
                      prorationMode:
                      ProrationMode.immediateWithTimeProration,
                    )
                        : null);
              } else {
                purchaseParam = PurchaseParam(
                  productDetails: productDetails,
                );
              }

              print("Is product Consumable "+ (productDetails.id == kConsumableId).toString());
              if (productDetails.id == kConsumableId) {
                controller.inAppPurchase.buyConsumable(
                    purchaseParam: purchaseParam,
                    autoConsume: kAutoConsume);
              } else {
                controller.inAppPurchase.buyNonConsumable(
                    purchaseParam: purchaseParam);
              }
            },
            child: Text(productDetails.price),
          ),
        );
      },
    ));
    return Card(
        child: Column(
            children: productList));
  }

  /*
  Card buildProductList(BuildContext context) {
    if (controller.loading.value) {
      return const Card(
          child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...')));
    }
    if (!controller.isAvailable.value) {
      return const Card();
    }
    const ListTile productHeader = ListTile(title: Text('Products for Sale'));
    final List<ListTile> productList = <ListTile>[];
    if (controller.notFoundIds.value.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${controller.notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().colorScheme.error)),
          subtitle: const Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    final Map<String, PurchaseDetails> purchases =
    Map<String, PurchaseDetails>.fromEntries(
        controller.purchases.value.map((PurchaseDetails purchase) {
          if (purchase.pendingCompletePurchase) {
    controller.inAppPurchase.completePurchase(purchase);
          }
          return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
        }));
    print("purchases INTO "+purchases.toString());
    productList.addAll(controller.products.value.map(
          (ProductDetails productDetails) {
        print("productDetails id "+productDetails.id);
        print("productDetails title "+productDetails.title);
        print("productDetails description "+productDetails.description);
        print("productDetails currencyCode "+productDetails.currencyCode);
        print("productDetails currencySymbol "+productDetails.currencySymbol);
        print("productDetails price "+productDetails.price);

        final PurchaseDetails? previousPurchase = purchases[productDetails.id];

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

        return ListTile(
          title: Text(
            productDetails.title,
          ),
          subtitle: Text(
            productDetails.description,
          ),
          trailing: previousPurchase != null && Platform.isIOS
              ? IconButton(
              onPressed: () => controller.confirmPriceChange(context),
              icon: const Icon(Icons.upgrade))
              : TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green[800],
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              late PurchaseParam purchaseParam;

              if (Platform.isAndroid) {
                // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                // verify the latest status of you your subscription by using server side receipt validation
                // and update the UI accordingly. The subscription purchase status shown
                // inside the app may not be accurate.
                final GooglePlayPurchaseDetails? oldSubscription =
                controller.getOldSubscription(productDetails, purchases);

                purchaseParam = GooglePlayPurchaseParam(
                    productDetails: productDetails,
                    changeSubscriptionParam: (oldSubscription != null)
                        ? ChangeSubscriptionParam(
                      oldPurchaseDetails: oldSubscription,
                      prorationMode:
                      ProrationMode.immediateWithTimeProration,
                    )
                        : null);
              } else {
                purchaseParam = PurchaseParam(
                  productDetails: productDetails,
                );
              }

              print("Is product Consumable "+ (productDetails.id == kConsumableId).toString());
              if (productDetails.id == kConsumableId) {
                controller.inAppPurchase.buyConsumable(
                    purchaseParam: purchaseParam,
                    autoConsume: kAutoConsume);
              } else {
                controller.inAppPurchase.buyNonConsumable(
                    purchaseParam: purchaseParam);
              }
            },
            child: Text(productDetails.price),
          ),
        );
      },
    ));

    return Card(
        child: Column(
            children: <Widget>[productHeader, const Divider()] + productList));
  }
  */

  Widget buildRestoreButton(BuildContext context) {
    if (controller.loading.value) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            // onPressed: () => controller.inAppPurchase.restorePurchases(),
            // onPressed: () => controller.restoreStoreInfo(),
            onPressed: () async {
              await controller.inAppPurchase.restorePurchases();
              // controller.getSubscriptionProductsList();
            },
            child: const Text('Restore purchases'),
          ),
        ],
      ),
    );
  }

  Widget addBulletString(String title, Color color, double fontSize){
    return Text("\u2022 " + title,style: TextStyle(color: color, fontSize: fontSize));
  }
}