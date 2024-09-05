import 'package:flutter/material.dart';

import 'app_constants.dart';

const primary_bg_blue= Color(0xffA6DFFE);
const primary_bg= Color(0xffffffff);
const primary_bg_light= Color(0xffE6EEFF);
const primary_fg= Color(0xffFFF8E9);
const lightprimary= Color(0xffF7F7FC);
const settingSeperator= Color(0xffEDEDED);
const primary= Color(0xffFFC344);
const disabledButtonColor= Color(0xffbe944d);
const black=Color(0xff1A1A1A);
const border_black=Color(0x1a1a1a1a);
const black_transparent=Color(0xe61a1a1a);
const quinary=Color(0xffffffff);
const secondarydark=Color(0xff725B2B);
const tertiarydark=Color(0xff494949);
const secondary=Color(0x4049C5F6);
const dark=Color(0xff1A1A1A);
const titleColor=Color(0xff000000);
const unselectedDark=Color(0xff858585);
const grey=Color(0xffE2E2E2);
const secondaryGrey=Color(0xffF3F3F3);
const darkGrey=Color(0xff7D7D7D);
const cream=Color(0xffd2d0d0);
const textDarkGrey=Color(0xff434343);
const textGrey=Color(0xff4D4D4D);
const elementGrey=Color(0xffF6F6F6);
const veryDarkGrey=Color(0xff494949);
const deepDarkGrey=Color(0xff545454);
const purple=Color(0xff5E4296);
const popUpBg=Color(0xffFDFDFD);
const transperant=Colors.transparent;
const darkBlue=Color(0xff708697);
const linkColor=Color(0xff4F66D0);
const textOnselectedColor= Color(0xff9E803F);
const textNotselectedColor= Color(0xff856F40);
const boxNotselectedColor= Color(0xffC9AA69);

const green=Color (0xff3CAB15);
const red=Color(0xffFF0000);
const redAccent=Color(0xffFF6363);
const lightQuaternary=Color(0xffD4BCFF);

const quizTransBlack=Color(0x33000000);
const lightTransBlack=Color(0xB0000000);
const transBlack=Color(0x99000000);

ThemeData buildAbsalyTheme({bool isDarkMode = false}) {
  final ThemeData base = isDarkMode ? ThemeData.dark() : ThemeData.light();
  final ColorScheme colorScheme = isDarkMode ? darkColorScheme : lightColorScheme;

  return base.copyWith(
    colorScheme: colorScheme,
    textTheme: buildAbsalyTextTheme(base.textTheme),
  );
}


const defaultLetterSpacing = 0.03;
const ColorScheme lightColorScheme = ColorScheme(
  primary: primary,
  secondary: secondary,
  surface: primary_fg,
  error: red,
  onPrimary: black,
  onSecondary: quinary,
  onSurface: tertiarydark,
  onError: primary_bg,
  brightness: Brightness.light,
);

const ColorScheme darkColorScheme = ColorScheme(
  primary: primary,
  secondary: secondary,
  surface: tertiarydark,
  error: red,
  onPrimary: quinary,
  onSecondary: black,
  onSurface: lightprimary,
  onError: primary_bg,
  brightness: Brightness.dark,
);

TextTheme buildAbsalyTextTheme(TextTheme base) {
  return base
      .copyWith(
    bodySmall: base.bodySmall?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: defaultLetterSpacing,
    ),
    labelLarge: base.labelLarge?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: defaultLetterSpacing,
    ),
    labelSmall: base.labelSmall?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: defaultLetterSpacing,
    ),
    titleMedium: base.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 30,
      letterSpacing: defaultLetterSpacing,
    ),
    titleLarge: base.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 40,
      letterSpacing: defaultLetterSpacing,
    ),
  )
      .apply(
    fontFamily: RUBIK_FONT,
    displayColor: dark,
    bodyColor: dark,
  );
}


const Color candyRed50 = Color(0xFFFFBEB8);
const Color candyRed100 = Color(0xFFF88F79);
const Color candyRed300 = Color(0xFFFF6054);
const Color candyRed400 = Color(0xFFEAA4A4);

const Color absalyBrown900 = Color(0xFF442B2D);
const Color absalyBrown600 = Color(0xFF7D4F52);

const Color absalyErrorRed = Color(0xFFC5032B);

const Color absalySurfaceWhite = Color(0xFFFFFBFA);
const Color absalyBackgroundWhite = Colors.white;