import 'package:flutter/material.dart';
import 'package:quran/utils/app_consts.dart';

class IntroButtonWidget extends StatelessWidget {
  const IntroButtonWidget({super.key, required this.onPress});
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: AppConsts.getWidth(context)*0.45,
        height: AppConsts.getHeight(context)*0.07,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Center(
            child: Text(
          "Get Started",
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Colors.white),
        )),
      ),
    );
  }
}
