
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class CommanDialog {
  static showLoading({String title = "Loading..."}) {
    Get.dialog(
      SizedBox(
        width: 40,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        color: dark,
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  static showErrorDialog(
      {String title = "Oops Error",
      String description = "Something went wrong "}) {
    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static showToast(BuildContext context,String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

/*
  static deleteTheClubDialog(String title, dynamic onPressed) {
    Get.dialog(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 40),
      child: SizedBox(
        width: 50,
        child: Dialog(
          backgroundColor: redAccent,
          alignment: Alignment.topRight,
          insetPadding: const EdgeInsets.only(left: 40),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: GestureDetector(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: quinary, fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  static topNavigateDialog(String title, dynamic onPressed) {
    Get.dialog(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 40),
      child: SizedBox(
        width: 50,
        child: Dialog(
          backgroundColor: grey,
          alignment: Alignment.topRight,
          insetPadding: const EdgeInsets.only(left: 60),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: GestureDetector(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: dark, fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  */
  static routineDialog(
    String title,
    String description,
    bool isHabit,
    String time,
    int currentDate,
    int challengeDuration,
    dynamic check,
    dynamic edit,
    delete,
  ) {
    print("Get.dialog routineDialog ");
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: check,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: green,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SvgPicture.asset(
                              "assets/image/check.svg",
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    addHorizontalSpace(15),
                    GestureDetector(
                      onTap: edit,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: purple,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              "assets/image/edit.svg",
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    addHorizontalSpace(15),
                    GestureDetector(
                      onTap: delete,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              "assets/image/trash.svg",
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              addVerticalSpace(5),
              Text(
                isHabit
                    ? "#Habit"
                    : "#Challenge Day $currentDate of $challengeDuration",
                style: const TextStyle(
                    color: darkBlue, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              addVerticalSpace(0),
              Text(
                title,
                style: const TextStyle(
                    color: dark, fontSize: 20, fontWeight: FontWeight.w700),
              ),
              addVerticalSpace(0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: SvgPicture.asset("assets/image/clock.svg"),
                  ),
                  addHorizontalSpace(5),
                  Text(
                    time,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: darkBlue,
                        fontSize: 12),
                  ),
                ],
              ),
              addVerticalSpace(5),
              Text(
                '"$description"',
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: lightTransBlack,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static deleteTheAccountDialog(dynamic onConfirmPressed) {
    Get.dialog(
      Dialog(
        backgroundColor: quinary,
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Delete the Account",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: dark,
                  ),
                ),
                addVerticalSpace(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        CommanDialog.hideLoading();
                      },
                      child: Container(
                        width: 110,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: grey,
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    addHorizontalSpace(30),
                    InkWell(
                      onTap: () async{
                        CommanDialog.hideLoading();
                        await onConfirmPressed();
                      },
                      child: Container(
                        width: 110,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: red,
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Text(
                              "Proceed",
                              style: TextStyle(
                                color: quinary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
