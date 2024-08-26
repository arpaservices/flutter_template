import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../bindings/generic_binding.dart';
import '../../controllers/home_controller.dart';
import '../../utils/supportUI/widget_function.dart';


class HomeScreen extends GetView<HomeController> {
  final HomeController _homeController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final scrWidth =MediaQuery.sizeOf(context).width;
    final scrHeight =MediaQuery.sizeOf(context).height;


    GenericBinding(HomeController()).dependencies();
    final HomeController controller = Get.find<HomeController>();


    //controller.callAuthenticateAPI(NetworkConstantSuperApp.AUTHENTICATE);
    return
      Obx(() =>
          PopScope(
            child: Scaffold(
            backgroundColor: primary_bg,
            body: IndexedStack(
              index: controller.currentPage.value,
              children: [
              ],),
            bottomNavigationBar:
            BottomNavigationBar(
                backgroundColor: quinary,
                elevation: 20,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: controller.currentPage.value,
                onTap: (value) {
                  // controller.currentPage.value = value;
                  if (value == 2) {
                    _showAddEntrySheet(context);
                  }else{
                    controller.currentPage.value = value;
                  }
                  if (kDebugMode) {
                    print("currentPage ${controller.currentPage.value}");
                    print("value $value");
                  }
                },
                items:
                List.generate(
                    bottomNavigationTxt.length,
                        (index) => BottomNavigationBarItem(

                      label: bottomNavigationTxt[index],
                      icon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   width: size.width / 5 - 40 / 5,
                          //   height: 6,
                          // ),
                          // addVerticalSpace(5),
                          SvgPicture.asset(
                            bottomNavUnSelectedImage[index],
                            color: index ==2 ?dark:unselectedDark,
                            // width:  index ==2 ?MediaQuery.of(context).size.width / 10:MediaQuery.of(context).size.width / 14,
                            // height:  index==2?MediaQuery.of(context).size.width / 10:MediaQuery.of(context).size.width / 14,
                            width: index ==2 ?42:28,
                            height: index ==2 ?42:28,
                          ),
                          addVerticalSpace(3),
                          const Center(
                            heightFactor: 0.6,
                            child: SizedBox(
                              height: 3,
                              width: 15,
                            ),
                          ),
                          // addVerticalSpace(10),
                          // Text(
                          //   bottomNavigationTxt[index],
                          //   style: const TextStyle(
                          //       fontWeight: FontWeight.w500, fontSize: 11, color: unselectedDark),
                          // ),
                        ],
                      ),
                      activeIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   width: size.width / 5 - 40 / 5,
                          //   height: 6,
                          //   color: primary,
                          // ),
                          // addVerticalSpace(5),
                          SvgPicture.asset(
                            bottomNavSelectedImage[index],
                            color: primary,
                            width: 28,
                            height: 28,
                          ),
                          addVerticalSpace(3),
                          // Text(
                          //   bottomNavigationTxt[index],
                          //   style: const TextStyle(
                          //       fontWeight: FontWeight.w500, fontSize: 11, color: primary),
                          // ),
                          Center(
                            heightFactor: 0.6,
                            child: Container(
                              height: 4,
                              width:10,
                              decoration: const BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(10),
                                  right: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    )
                )

            ),),
              canPop: true,
              onPopInvoked:  (didPop) {
              },
              // onWillPop: () async => false,
          )
    );
  }


}

class AddEntryForms {
  final String formName;
  final String formType;

  // final IconData formIcon;
  final String formIcon;
  final String destinationPage ;
  final int formDuration;

  AddEntryForms(
      this.formName,
      this.formType,
      this.formIcon,
      this.destinationPage,
      {
        required this.formDuration,
      });

}
