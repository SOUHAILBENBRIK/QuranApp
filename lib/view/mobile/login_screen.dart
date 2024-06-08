import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/controller/auth_controller.dart';
import 'package:quran/utils/app_colors.dart';
import 'package:quran/utils/app_consts.dart';
import 'package:quran/utils/app_route.dart';
import 'package:quran/widgets/intro_button_widget.dart';
import 'package:quran/widgets/login_button_widget.dart';
import 'package:toast/toast.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: AppConsts.getHeight(context),
          width: AppConsts.getWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 2,
              ),
              Text(
                "Welcome to Our App",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.01,
              ),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.05,
              ),
              SvgPicture.asset(
                "assets/images/introm_image.svg",
                height: AppConsts.getHeight(context) * 0.5,
                width: AppConsts.getWidth(context) * 0.9,
              ),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.02,
              ),
              GoogleButton(
                  text: "Login with Google",
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  onPress: () {
                    AuthController().signInWithGoogle().then((value) {
                      Navigator.pushReplacementNamed(
                          context, AppRoute.homeScreenMobile);
                    }).catchError((onError) {
                      Toast.show("Error :" + onError.toString(),backgroundColor: Colors.redAccent);
                    });
                  }),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
