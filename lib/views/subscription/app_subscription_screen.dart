import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/subscription/app_subscription_controller.dart';
import '../../utils/core/app_colors.dart';
import '../../utils/core/app_enums.dart';
import '../../utils/core/app_strings.dart';
import '../../utils/supportUi/deviceInfo.dart';
import '../../utils/supportUi/widget_function.dart';

class AppSubscriptionScreen extends GetView<AppSubscriptionController> {


  @override
  void dispose() {

  }

  void _purchaseSubscription() async {

    controller.purchaseFunction();
  }

  @override
  Widget build(BuildContext context) {
    // IAPItem subsItemOne = controller.itemsArr.value[0];
    // IAPItem subsItemTwo = controller.itemsArr.value[1];
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
            child: Obx(() => Container(
              height: DeviceInfo.deviceHeight()*0.95,
              child: (controller.state.value == States.LOADING) ? Center(child: CircularProgressIndicator(),) :
              // (controller.itemsArr.value.length == 0) ?
              // Center(child: Column(
              //   children: [
              //     ElevatedButton(
              //       onPressed: _purchaseSubscription,
              //       child: Text('Buy Premium Membership'),
              //     ),
              //     Text("NO Data Available"),
              //   ],
              // ),) :
              SingleChildScrollView(
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
                                      color: (controller.selectedPlan.value == controller.getSubsPlanDesc(0)) ? primary : settingSeperator
                                  ),
                                  height: 40,
                                  width: DeviceInfo.deviceWidth()*0.33,
                                  child: Center(child: Text(
                                    controller.getSubsPlanDesc(0),
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
                                    color: (controller.selectedPlan.value == controller.getSubsPlanDesc(1)) ? primary : settingSeperator
                                ),
                                height: 40,
                                width: DeviceInfo.deviceWidth()*0.33,
                                child: Center(child: Text(
                                  controller.getSubsPlanDesc(1),
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
                        addVerticalSpace(20),
                        Container(
                          width: DeviceInfo.deviceWidth()*0.85,
                          color: primary_bg.withOpacity(0.15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              addVerticalSpace(20),
                              getPPHattonText(
                                  controller.getSubsPlanTitle(controller.getSubsPlanIndex(controller.selectedPlan.value)), TextAlign.center, dark,
                                  FontWeight.w500, 25),
                              addVerticalSpace(20),
                              // (controller.selectedPlan.value == SubscriptionEnum.getPlanInString(Subscription.yearly)) ? Container(child: Text("\u0024 " + controller.planPremiumList[2] + "/yr", style: TextStyle(fontFamily: "PP Hatton",
                              //     decoration: TextDecoration.lineThrough, color: darkGrey, fontWeight: FontWeight.w700, fontSize: 40),),) : Container(),
                              // getNewFontText(
                              //     (controller.selectedPlan.value.toLowerCase() == SubscriptionEnum.getPlanInString(Subscription.monthly).toLowerCase()) ? "\u0024 " + controller.getSubsPlanPrice(controller.getSubsPlanIndex(controller.selectedPlan.value)) + "/mo" : "\u0024 " + controller.getSubsPlanPrice(controller.getSubsPlanIndex(controller.selectedPlan.value)) + "/yr", TextAlign.center, dark,
                              //     FontWeight.w700, 35),
                              getPPHattonText(
                                  (controller.selectedPlan.value.toLowerCase() == SubscriptionPlansEnum.getPlanInString(SubscriptionPlans.MONTHLY).toLowerCase()) ? controller.getSubsPlanPrice(controller.getSubsPlanIndex(controller.selectedPlan.value)) + "/mo" : controller.getSubsPlanPrice(controller.getSubsPlanIndex(controller.selectedPlan.value)) + "/yr", TextAlign.center, dark,
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
                      ],
                    ),
                    addVerticalSpace(DeviceInfo.deviceHeight()*0.1),
                    Column(
                      children: [
                        (controller.purchasesArr.value.length > 0) ?
                        Container(width: DeviceInfo.deviceWidth()*0.85, child: getPPHattonText(
                            "Subscription Activated", TextAlign.center, dark,
                            FontWeight.w600, 23),) :
                        addVerticalSpace(10),
                        (controller.purchasesArr.value.length > 0) ?
                        Container(width: DeviceInfo.deviceWidth()*0.85, child: Text(
                            "Congratulations, you have successfully activated " + controller.selectedItem.value.description! + " premium access to all features of Absaly, Enjoy it!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300, color: dark,)),) :
                        SizedBox(
                          width: DeviceInfo.deviceWidth()*0.8,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {

                              // if (controller.selectedPlan.value == SubscriptionEnum.getPlanInString(Subscription.monthly)){
                              //   controller.purchaseMonthlyPackage();
                              // }else if (controller.selectedPlan.value == SubscriptionEnum.getPlanInString(Subscription.yearly)){
                              //   controller.purchaseYearlyPackage()
                              // }

                              controller.purchasePackage();

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
                              controller.dispose();
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
            ),)),
      ),
    );
  }

  Widget addBulletString(String title, Color color, double fontSize){
    return Text("\u2022 " + title,style: TextStyle(color: color, fontSize: fontSize));
  }
}