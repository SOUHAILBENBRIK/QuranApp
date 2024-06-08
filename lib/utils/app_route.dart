import 'package:flutter/material.dart';
import 'package:quran/view/layout_build_screen.dart';
import 'package:quran/view/mobile/chapter_listen_screen.dart';
import 'package:quran/view/mobile/chapter_screen.dart';
import 'package:quran/view/mobile/home_screen.dart';
import 'package:quran/view/mobile/intro_screen.dart';
import 'package:quran/view/mobile/login_screen.dart';
import 'package:quran/view/mobile/profile_screen.dart';

class AppRoute {
  static String layoutBuildScreen = "/layoutBuildScreen";
  //mobile part
  static String introScreenMobile = "/introScreenMobile";
  static String homeScreenMobile = "/homeScreenMobile";
  static String loginScreenMobile = "/loginScreenMobile";
  static String profileScreenMobile = "/profileScreenMobile";
  static String chapterScreenMobile = "/chapterScreenMobile";
  static String chapterListeanScreenMobile = "/chapterListeanScreenMobile";

  static Map<String, Widget Function(BuildContext)> routes = {
    layoutBuildScreen: (context) => const LayoutBuildScreen(),
    introScreenMobile: (context) => const IntroScreenMobile(),
    homeScreenMobile: (context) => const HomeScreen(),
    loginScreenMobile: (context) => const LoginScreenMobile(),
    profileScreenMobile: (context) => const ProfileScreen(),
    chapterScreenMobile : (context) => const ChapterScreen(),
    chapterListeanScreenMobile : (context) => const ChapterListenScreen()
  };
}
