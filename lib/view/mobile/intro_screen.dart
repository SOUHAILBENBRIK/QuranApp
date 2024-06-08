import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/utils/app_colors.dart';
import 'package:quran/utils/app_consts.dart';
import 'package:quran/utils/app_route.dart';
import 'package:quran/widgets/intro_button_widget.dart';

class IntroScreenMobile extends StatelessWidget {
  const IntroScreenMobile({super.key});

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
                "Quran App",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.01,
              ),
              Text(
                "Learn Quran and Recite once everyday",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.05,
              ),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    "assets/images/introm_image.svg",
                    height: AppConsts.getHeight(context) * 0.5,
                    width: AppConsts.getWidth(context) * 0.9,
                  ),
                  Positioned(
                      bottom: -25,
                      child: IntroButtonWidget(onPress: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoute.loginScreenMobile);
                      })),
                ],
              ),
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
