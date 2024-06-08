import 'package:flutter/material.dart';
import 'package:quran/utils/app_colors.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: AppColors.primeColor,
      canvasColor: AppColors.secondColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(color: AppColors.primeColor,fontSize: 28,fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: AppColors.primeColor1,fontSize: 20,fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: AppColors.greyColor,fontSize: 18,),
        )//app title

    );
  }
  static ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: AppColors.primeColor,
      canvasColor: AppColors.secondColor,
    );
  }
}
