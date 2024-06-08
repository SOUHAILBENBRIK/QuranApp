import 'package:flutter/material.dart';

class AppConsts {
  static String url = "https://api.quran.com/api/v4";
  static double getHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }
}
