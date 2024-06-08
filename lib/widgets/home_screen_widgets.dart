import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/controller/api_controller.dart';
import 'package:quran/model/chapter.dart';
import 'package:quran/utils/app_colors.dart';
import 'package:quran/utils/app_consts.dart';
import 'package:quran/utils/app_route.dart';
import 'package:quran/widgets/bottom_sheet_widget.dart';

class HomeScreenWidgets {
  static Center allChapter() {
    return Center(
        child: FutureBuilder<List<ChapterModule>?>(
            future: ApiController.getAllChapter(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListView(
                  children: snapshot.data!.map((chapter) {
                    return HomeScreenWidgets.chapter(context, chapter: chapter);
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Erro"),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  static Widget chapter(BuildContext context,
      {required ChapterModule chapter}) {
    return SizedBox(
      width: AppConsts.getWidth(context),
      child: ListTile(
          onTap: () {
            Navigator.pushReplacementNamed(
                context, AppRoute.chapterScreenMobile,arguments: chapter);
            
          },
          leading: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset("assets/icons/muslim.svg"),
              Text(chapter.id.toString()),
            ],
          ),
          title: Text(chapter.name_simple),
          subtitle: Row(
            children: [
              Text(chapter.revelation_place),
              const SizedBox(
                width: 10,
              ),
              Text(chapter.verses_count.toString() + " verses"),
            ],
          ),
          trailing: Text(
            chapter.name_arabic,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: AppColors.primeColor1, fontWeight: FontWeight.bold),
          )),
    );
  }

  static AppBar appBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, AppRoute.profileScreenMobile);
          },
          icon: Icon(
            Icons.person_2,
            color: AppColors.greyColor,
            size: 26,
          ),
        )
      ],
      centerTitle: true,
      title: Text(
        "Quran App",
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
