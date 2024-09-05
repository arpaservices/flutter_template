import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_constants.dart';


Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget showLoaderOnButton(Color color) {
  return SizedBox(
      height: 50,
      width: 50,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: CircularProgressIndicator(
          color: color,
        ),
      ));
}

Widget getPPHattonText(String string, TextAlign textAlign, Color txtColor, FontWeight fontWeight, double size,) {
  return Text(
    string,
    textAlign: textAlign,
    style: TextStyle(
        fontFamily: PP_HATTON_FONT,
        color: txtColor, fontWeight: fontWeight, fontSize: size),
  );
}
Widget getRubikFontText(String string, TextAlign textAlign, Color txtColor, FontWeight fontWeight, double size,) {
  return Text(
    string,
    textAlign: textAlign,
    style: TextStyle(
        fontFamily: RUBIK_FONT,
        color: txtColor, fontWeight: fontWeight, fontSize: size),
  );
}

Widget getTitleText(String string, TextAlign textAlign, Color txtColor, FontWeight fontWeight, double size,) {
  return Text(
    string,
    textAlign: textAlign,
    style: TextStyle(
        fontFamily: BERKSHIRE_SWASH_FONT,
        color: txtColor, fontWeight: fontWeight, fontSize: size),
  );
}

Widget getTextInputWithHintText(TextEditingController controller, String hintText, TextAlign textAlign, Color hintTxtColor, FontWeight fontWeight,String fontFamily, double size,TextStyle inputTxtStyle) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: fontFamily, color: hintTxtColor,fontSize: size)
    ),
    maxLines: 2,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Empty!';
      }
      return null;
    },
    textAlign: textAlign,
    style: inputTxtStyle,
  );
}

class ButtonSelector extends StatelessWidget {
  final String text, icon;
  final double weight, height;
  final Color backColor;
  final Color txtColor;

  const ButtonSelector(
      {super.key,
        required this.text,
        required this.icon,
        required this.weight,
        required this.height,
        required this.backColor,
        required this.txtColor});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backColor,
        border: Border.all(
          color: darkGrey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                icon,
                width: weight,
                height: height,
              ),
            ),
            addHorizontalSpace(20),
            Text(
              "Continue with $text",
              style: TextStyle(
                  color: txtColor, fontWeight: FontWeight.w400, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}

void _showToast(BuildContext context,String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(text),
      action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

class EditText extends StatelessWidget {
  final String textHint;
  final textType, controller;
  int? minLine;
  int? maxLine;
  int? maxLength;
  final double height;

  EditText(
      {super.key,
        required this.textHint,
        required this.textType,
        required this.controller,
        required this.height,
        this.minLine,
        this.maxLine,
        this.maxLength,
      });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        onTapOutside: (PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        keyboardType: textType,
        minLines: minLine ?? 1,
        // maxLines: minLine==null?1:5,
        maxLines: maxLine,
        maxLength: maxLength,
        textAlign: TextAlign.start,
        // textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: const TextStyle(
                color: dark, fontWeight: FontWeight.w400, fontSize: 15),
            labelText: textHint,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: dark, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: dark, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primary, width: 1),
              borderRadius: BorderRadius.circular(5),
            )),
        cursorColor: dark,
        style:
        const TextStyle(color: dark, fontWeight: FontWeight.w500, fontSize: 17),
      ),
    );
  }
}