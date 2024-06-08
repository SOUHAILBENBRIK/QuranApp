// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/controller/auth_controller.dart';
import 'package:quran/utils/app_colors.dart';
import 'package:quran/utils/app_consts.dart';
import 'package:quran/widgets/home_screen_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 
  @override
  Widget build(BuildContext context) {
     List<Widget> screens = [chapterScreen(context), chapterScreen(context),chapterScreen(context)];
    return Scaffold(
      appBar: HomeScreenWidgets.appBar(context),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        
        backgroundColor: Colors.white,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/icons/chapter.svg",color: AppColors.primeColor1,),
            icon: SvgPicture.asset("assets/icons/chapter.svg",color: AppColors.greyColor,),
            label: ""
          ),
          BottomNavigationBarItem(
           activeIcon: SvgPicture.asset("assets/icons/pray.svg",color: AppColors.primeColor1,),
            icon: SvgPicture.asset("assets/icons/pray.svg",color: AppColors.greyColor,),
            label: ""
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/icons/bookmark.svg",color: AppColors.primeColor1,),
            icon: SvgPicture.asset("assets/icons/bookmark.svg",color: AppColors.greyColor,),
            label: ""
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  SafeArea chapterScreen(BuildContext context) {
    return SafeArea(
      minimum:
          EdgeInsets.symmetric(horizontal: AppConsts.getWidth(context) * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: AppConsts.getHeight(context) * 0.01,
          ),
          _widget1(context),
          SizedBox(
            height: AppConsts.getHeight(context) * 0.03,
          ),
          _widget2(context),
          SizedBox(
            height: AppConsts.getHeight(context) * 0.03,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text("Chapters:",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: AppColors.primeColor)),
          ),
          widget3(context)
        ],
      ),
    );
  }
}

Widget widget3(BuildContext context) {
  return Expanded(
    child: HomeScreenWidgets.allChapter(),
  );
}

Widget _widget2(BuildContext context) {
  return Container(
    width: AppConsts.getWidth(context) * 0.9,
    height: AppConsts.getHeight(context) * 0.18,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primeColor.withOpacity(0.4),
              AppColors.primeColor.withOpacity(0.6),
              AppColors.primeColor
            ])),
    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
    child: Row(
      children: [
        SizedBox(
          width: AppConsts.getWidth(context) * 0.02,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.book_outlined,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Last Read",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: AppConsts.getHeight(context) * 0.03,
            ),
            Text("Surah Al-Fatihah",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Colors.white)),
            SizedBox(
              height: AppConsts.getHeight(context) * 0.006,
            ),
            Text("Ayah No: 1",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Colors.white)),
          ],
        ),
        const Spacer(),
        Container(
            margin: EdgeInsets.only(top: AppConsts.getHeight(context) * 0.02),
            child: SvgPicture.asset(
              "assets/images/Quran.svg",
              width: AppConsts.getWidth(context) * 0.4,
            ))
      ],
    ),
  );
}

Widget _widget1(BuildContext context) {
  return Align(
    alignment: Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Asslamualaikum",
          style:
              Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          AuthController().getCurrentUser()?.displayName ?? "",
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
