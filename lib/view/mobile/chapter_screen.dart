import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/controller/api_controller.dart';
import 'package:quran/model/ayah.dart';
import 'package:quran/model/chapter.dart';
import 'package:quran/utils/app_colors.dart';
import 'package:quran/utils/app_consts.dart';
import 'package:quran/utils/app_route.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key});

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  @override
  void initState() {
    
    /*Future.delayed(Duration.zero, () {
      ChapterModule chapter =
        ModalRoute.of(context)?.settings.arguments as ChapterModule;
    ApiController.getChapterAyah(chapter_id: chapter.id).then((value) {
      print(value);
    });
    
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChapterModule chapter =
        ModalRoute.of(context)?.settings.arguments as ChapterModule;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.greyColor,
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoute.homeScreenMobile);
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AppRoute.chapterListeanScreenMobile,arguments: chapter);
            },
            child: SvgPicture.asset("assets/icons/play.svg"),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        title: Text(
          chapter.name_simple,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 20),
        child: SizedBox(
          height: AppConsts.getHeight(context),
          width: AppConsts.getWidth(context),
          child: Column(
            children: [
              _topWidget(context, chapter: chapter),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.03,
              ),
              listPfAyah(chapter)
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<Ayah>?> listPfAyah(ChapterModule chapter) {
    return FutureBuilder<List<Ayah>?>(
        future: ApiController.getChapterAyah(chapterId: chapter.id),
        builder: (context, snapshot) {
        
          if (snapshot.hasData && snapshot.data != null) {
            int id = 0;
            return Expanded(
              child: ListView(
                children: snapshot.data!.map((element) {
                  id++;
                  return _ayahText(context, ayah: element, id: id);
                }).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Erro"),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

Widget _ayahText(BuildContext context, {required Ayah ayah, required int id}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    width: AppConsts.getWidth(context),
    height: AppConsts.getHeight(context) * 0.2,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      children: [
        Container(
          width: AppConsts.getWidth(context) * 0.9,
          height: AppConsts.getHeight(context) * 0.05,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: AppColors.greyColor.withOpacity(0.1)),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.primeColor,
                child: Center(
                    child: Text(
                  (id).toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                )),
              ),
              const Spacer(),
              iconSvg(path: "assets/icons/share.svg", onTap: () {}),
              const SizedBox(
                width: 20,
              ),
              iconSvg(path: "assets/icons/book.svg", onTap: () {}),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppConsts.getHeight(context) * 0.015,
        ),
        Container(
          height: AppConsts.getHeight(context) * 0.08,
          alignment: Alignment.topRight,
          child: Text(
            ayah.text_imlaei,
            overflow: TextOverflow.fade,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: AppConsts.getHeight(context) * 0.01,
        ),
        Divider(
          color: Colors.grey.withOpacity(0.2),
        ),
      ],
    ),
  );
}

Widget iconSvg({required String path, required Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: SvgPicture.asset(path),
  );
}

Widget _topWidget(context, {required ChapterModule chapter}) {
  return Container(
    width: AppConsts.getWidth(context) * 0.9,
    height: AppConsts.getHeight(context) * 0.3,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(35)),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primeColor.withOpacity(0.4),
            AppColors.primeColor.withOpacity(0.6),
            AppColors.primeColor
          ]),
      boxShadow: [
        BoxShadow(
          color: AppColors.primeColor1.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          right: -1,
          child: Container(
              margin: EdgeInsets.only(top: AppConsts.getHeight(context) * 0.02),
              child: SvgPicture.asset(
                "assets/images/Quran.svg",
                width: AppConsts.getWidth(context) * 0.4,
              )),
        ),
        Positioned.fill(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Container(
                  color: Colors.black.withOpacity(0), // transparent container
                ))),
        Positioned(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppConsts.getHeight(context) * 0.03,
              ),
              Text(chapter.name_simple,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.white)),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.01,
              ),
              Text(chapter.name_arabic,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.white)),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.01,
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: AppConsts.getWidth(context) * 0.2),
                  child: const Divider()),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    chapter.revelation_place.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    width: AppConsts.getWidth(context) * 0.05,
                  ),
                  Text(
                    "${chapter.verses_count} VERSES",
                    style: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset("assets/icons/bism.svg"),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.02,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
