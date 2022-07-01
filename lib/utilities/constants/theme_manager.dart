import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/constants/color_manager.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.kLightGrey,
    primaryColor: ColorManager.kRed,
    fontFamily: 'metropolis',
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      labelStyle: const TextStyle(
        color: ColorManager.kGrey,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.0),
        borderSide: const BorderSide(
          color: ColorManager.kGrey,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.0),
        borderSide: const BorderSide(
          color: ColorManager.kGrey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.0),
        borderSide: const BorderSide(
          color: ColorManager.kWhite,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.0),
        borderSide: const BorderSide(
          color: ColorManager.kRed,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.0),
        borderSide: const BorderSide(
          color: ColorManager.kRed,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ColorManager.kRed,
        shadowColor: ColorManager.kBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
        ),
      ),
    ),
  );
}
