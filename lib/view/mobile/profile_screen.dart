

import 'package:flutter/material.dart';
import 'package:quran/controller/auth_controller.dart';
import 'package:quran/utils/app_colors.dart';
import 'package:quran/utils/app_consts.dart';
import 'package:quran/utils/app_route.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.primeColor, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        height: AppConsts.getHeight(context),
        width: AppConsts.getWidth(context),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: AppConsts.getHeight(context) * 0.02,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoute.homeScreenMobile);
                    },
                  ),
                ],
              ),
              const Spacer(),
              _profileWidget(context),
              const Spacer(),
              _infoprofile(context),
              
            ],
          ),
        ),
      ),
    );
  }
}

Widget _infoprofile(BuildContext context) {
  return Container(
    width: AppConsts.getWidth(context),
    height: AppConsts.getHeight(context) * 0.6,
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        )),
    child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            
            SizedBox(
              height: AppConsts.getHeight(context) * 0.03,
            ),
            _button(context,
                label: "Sign out",
                color: AppColors.primeColor1.withOpacity(0.6),
                icon: Icons.info_outline, onPress: () async {
              await AuthController().signOut().then((_){
Navigator.pushReplacementNamed(context, AppRoute.loginScreenMobile);
              });
              
            }),
            const Spacer(),
            Text("@Souhail Ben Brik 💜",style: Theme.of(context).textTheme.displaySmall,),
            const SizedBox(height: 10,)
          ],
        )),
  );
}

Widget _button(BuildContext context,
    {required String label,
    required Color color,
    required IconData icon,
    required Function() onPress}) {
  return ListTile(
    splashColor: AppColors.primeColor1.withOpacity(0.3),
    onTap: onPress,
    leading: CircleAvatar(
      backgroundColor: color.withOpacity(0.2),
      radius: 25,
      child: Center(
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios_outlined,
      color: Colors.black,
      size: 24,
    ),
    title: Text(
      label,
      style: const TextStyle(color: Colors.black, fontSize: 16),
    ),
  );
}

Widget _profileWidget(BuildContext context) {
  var user = AuthController().getCurrentUser();
  return Column(
    children: [
      Visibility(
        visible:
            user != null && user.photoURL != null && user.photoURL!.isNotEmpty,
        replacement: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35,
          child: Icon(
            Icons.person,
            color: AppColors.primeColor,
            size: 30,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35,
          child: ClipOval(child: Image.network(user!.photoURL!)),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      (user.displayName != null && user.displayName!.isNotEmpty)
          ? Text(
              user.displayName!,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )
          : const SizedBox(),
      const SizedBox(
        height: 5,
      ),
      Text(
        user.email ?? "user@gmaail.com",
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      
    ],
  );
}
