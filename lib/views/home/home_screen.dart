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


    void _openEntryFormModal(BuildContext context) {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0), // Add padding for internal content
            height: MediaQuery.of(context).size.height * 0.5, // Set desired height
            decoration: BoxDecoration(
              color: Colors.white, // Adjust background color as needed
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0), // Adjust top radius to make it look like a card
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Handle onTap for Item 1
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Handle onTap for Item 2
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Item 3'),
                  onTap: () {
                    // Handle onTap for Item 3
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    void _showAddEntrySheet(BuildContext context) {
      //  List<AddEntryForms> addForms = [
      //   AddEntryForms("Add Habits", EntryType.NORMAL.name, Icons.add_circle_outline_outlined,AppRoutes.ADDENTRY, formDuration: 20),
      //   AddEntryForms("Add Health Habits", EntryType.HEALTH.name, Icons.add_circle_outline_outlined ,AppRoutes.ADDENTRY, formDuration: 40),
      //   AddEntryForms("Add Journal Entry", EntryType.JOURNAL.name, Icons.add_circle_outline_outlined  ,AppRoutes.ADDENTRY, formDuration: 30),
      // ];
       List<AddEntryForms> addForms = [
        // AddEntryForms("Add Task", EntryType.HABIT.name, 'assets/image/add_entry/add_task.svg',AppRoutes.ADDENTRY, formDuration: 20),
        AddEntryForms("Add Habbit", EntryType.HEALTHHABIT.name, 'assets/image/add_entry/add_habit.svg' ,AppRoutes.ADDENTRY, formDuration: 40),
        AddEntryForms("Add Journal Entry", EntryType.JOURNAL.name, 'assets/image/add_entry/add_journalentry.svg'  ,AppRoutes.JOURUNAL, formDuration: 30),
        // AddEntryForms("Add Reminder", EntryType.JOURNAL.name, 'assets/image/add_entry/add_reminder.svg'  ,AppRoutes.ADDENTRY, formDuration: 30),
      ];
      showModalBottomSheet<void>(
        isDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),color: primary_bg_light),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(20),
                        ),color: primary),
                        // height: scrHeight*0.05,
                        // width: scrHeight*0.07,
                        height: 40,
                        width: 40,
                        child: Center(child: Icon(Icons.close,size: 25,),),
                        // child: ,
                      ),
                    ),
                  ),
                  addVerticalSpace(20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: addForms.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          // Get.offNamed(addForms[index].destinationPage);
                          Navigator.pop(context);
                          String formType = addForms[index].formType;
                          if (formType.toLowerCase() == EntryType.JOURNAL.name.toLowerCase()){
                            Get.toNamed(AppRoutes.JOURUNALADD);
                          }else{
                            await
                            showModalBottomSheet<void>(
                              isDismissible: true,
                              isScrollControlled: true,scrollControlDisabledMaxHeightRatio: scrHeight,
                              context: context,
                              backgroundColor:primary ,
                              builder: (BuildContext context) {
                                return  SafeArea(
                                  child: Container(
                                      width: scrWidth,
                                      height: scrHeight*0.95,
                                      child: EntryFormWidget(
                                        GlobalKey<FormState>(),
                                        onClose: () {
                                          Navigator.pop(context);
                                          addEntryController.resetFields();
                                        } ,)
                                  ),
                                );
                              },
                            );
                          }

                        },

                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              width: double.infinity,
                              // height: scrHeight*0.08,
                              height:60,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: quinary),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  addHorizontalSpace(20),
                                  // Icon(addForms[index].formIcon,size: 40,),
                                  SvgPicture.asset(
                                    addForms[index].formIcon,
                                    height: 30,
                                    width: 30,
                                  ),
                                  addHorizontalSpace(30),
                                  Text(addForms[index].formName,style: TextStyle(color: dark,fontSize: 20,fontFamily:RUBIK_FONT,fontWeight: FontWeight.w500,),)
                                ],
                              ),
                              // subtitle: Text('Created By: ${habits[index].occurrenceFrequency}'),
                              // Add more details to display in the list tile as needed
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
        },
      );
    }
    //controller.callAuthenticateAPI(NetworkConstantSuperApp.AUTHENTICATE);
    return
      Obx(() =>
          PopScope(child: Scaffold(
            // appBar: AppBar(
            //   titleSpacing: 10,
            //   leadingWidth:  MediaQuery.sizeOf(context).width*0.20,
            //   actionsIconTheme: CupertinoIconThemeData(color: primary),
            //   titleTextStyle: TextStyle(
            //       fontSize: 23,
            //       fontWeight: FontWeight.w800,
            //       fontFamily: "PP Hatton",
            //     color: titleColor
            //   ),
            //   // toolbarHeight: MediaQuery.sizeOf(context).height*0.07,
            //   backgroundColor: primary_bg,
            //   centerTitle: true,
            //   leading: Container(
            //     padding:  EdgeInsets.all(15),
            //     child: Image.asset(splashLogoIcon),
            //   ),
            //   title: Text(
            //     AppTitles.app_name,
            //   ) ,
            //   actions: [
            //     // IconButton(
            //     //   icon: const Icon(Icons.logout),
            //     //   onPressed: () {
            //     //     _authController.signOut();
            //     //   },
            //     // ),
            //     IconButton(
            //       icon:  Container(
            //         margin: EdgeInsets.only(right: 10),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),color: quinary,),
            //           child: Padding(
            //             padding: const EdgeInsets.all(10.0),
            //             child: SvgPicture.asset(adjustIcon),
            //           )),
            //       onPressed: () {
            //         Get.toNamed(AppRoutes.SETTING);
            //       },
            //     ),
            //   ],
            // ),
            backgroundColor: primary_bg,
            body: IndexedStack(
              index: controller.currentPage.value,
              children: [
                DashboardScreen(),
                JournalScreen(),
                // AddEntryScreen(),
                DashboardScreen(),
                TipCategoryScreen(),

                ChartsScreen(),
                // ElevatedButton(onPressed: (){
                //   Get.offNamed(AppRoutes.JOURUNAL);
                // }, child: Text("GO to Journal"))
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
