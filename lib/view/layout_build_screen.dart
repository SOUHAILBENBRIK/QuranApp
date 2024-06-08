import 'package:flutter/material.dart';
import 'package:quran/controller/auth_controller.dart';
import 'package:quran/view/mobile/home_screen.dart';
import 'package:quran/view/mobile/intro_screen.dart';

class LayoutBuildScreen extends StatelessWidget {
  const LayoutBuildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return Center(
          child: Text('nothing to show'),
        );
      } else {
        if(AuthController().getCurrentUser() != null){
          return HomeScreen();
        }
        return IntroScreenMobile();
      }
    });
  }
}
