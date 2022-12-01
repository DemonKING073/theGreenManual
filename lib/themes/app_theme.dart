import 'package:flutter/material.dart';
import 'package:the_green_manual/common/constants/app_dimens.dart';

const fontFamily = "Quicksand";
const disabledColor = Color(0xFFbcbcbc);
const primaryColor = Color(0xff61B994);
const secondaryColor = Color(0xFF282724);
const lightGray = Color(0xFF3C3C3C);
const red = Color(0xFFFF4949);
const lightWhite = Color(0xFFDEDEDE);
const lightPrimaryCplor = Color(0xFF4189F5);
// const secondaryColor = Color(0xFF00da9f);
const shutleGrey = Color(0xFFf4f4f4);
const errorColor = Color(0xFFF76567);
const successColor = Color(0xFF00CC00);
const warningColor = Color(0xFFfce8bb);
const warningIconColor = Color(0xFFf3b31c);
const darkGrey = Color(0xFF959595);
const lightGrey = Color(0xFFe4e4e4);
const chipGrey = Color(0xFFededed);
const veryLightGrey = Color.fromARGB(255, 247, 247, 247);
const cursorColor = Color(0xFF666666);
const bodyColor = Color.fromARGB(255, 36, 36, 36);
const buttonColor = Color(0xFFFFFFFF);
const inputSuffixIconClor = Color(0xFF6dd819);
const backgroundColor = Color(0xFFf2f5fa);

const errorBorder = OutlineInputBorder(
  borderRadius: AppDimens.inputBorderRadius,
  borderSide: BorderSide(
    color: errorColor,
  ),
);

const enabledBorder = OutlineInputBorder(
  borderRadius: AppDimens.inputBorderRadius,
  borderSide: BorderSide(
    color: lightGrey,
  ),
);

const focusedBorder = OutlineInputBorder(
  borderRadius: AppDimens.inputBorderRadius,
  borderSide: BorderSide(
    color: darkGrey,
  ),
);

abstract class AppThemes {
  static ThemeData light = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    errorColor: errorColor,
    textSelectionTheme: ThemeData.light().textSelectionTheme.copyWith(
          cursorColor: cursorColor,
        ),
    textTheme: ThemeData.light()
        .textTheme
        .apply(
          bodyColor: bodyColor,
          fontFamily: fontFamily,
        )
        .copyWith(
          bodyText1: ThemeData.light().textTheme.bodyText1?.copyWith(
                fontSize: AppDimens.bodyFontSize,
              ),
        ),
    tabBarTheme: ThemeData.light().tabBarTheme.copyWith(
          labelStyle: const TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
          ),
        ),
    inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
          contentPadding: AppDimens.inputPadding,
          fillColor: Colors.white,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
        ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    cardTheme: ThemeData.light()
        .cardTheme
        .copyWith(margin: const EdgeInsets.symmetric(vertical: 4)),
  );
}
