import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quran/model/chapter.dart';
import 'package:quran/model/chapter_info.dart';
import 'package:quran/utils/app_colors.dart';
import 'package:quran/utils/app_consts.dart';

class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({super.key, required this.chapterInfo,required this.chapter});
  final ChapterInfo chapterInfo;
  final ChapterModule chapter;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
        color: Colors.white,),
      padding: EdgeInsets.only(top: 15,left: 6,right: 6),
          height: MediaQuery.of(context).size.height * 0.5,
          width: AppConsts.getWidth(context),
          
      child: Column(
        children: [
          Text(chapter.name_simple,style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.primeColor1),),
          
          Spacer(),
          Text(chapterInfo.short_text,textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.black,fontStyle: FontStyle.italic),),Spacer(),],
      ),
    );
  }
}
