import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/controller/api_controller.dart';
import 'package:quran/model/chapter.dart';
import 'package:quran/model/chapter_info.dart';
import 'package:quran/utils/app_colors.dart';
import 'package:quran/utils/app_consts.dart';
import 'package:quran/utils/app_route.dart';
import 'package:quran/widgets/bottom_sheet_widget.dart';

class ChapterListenScreen extends StatefulWidget {
  const ChapterListenScreen({super.key});

  @override
  State<ChapterListenScreen> createState() => _ChapterListenScreenState();
}

class _ChapterListenScreenState extends State<ChapterListenScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();
  double _sliderValue = 0.0;
  bool _isPlaying = false;
  Duration _duration = Duration();
  Duration _position = Duration();
  @override
  void initState() {
    super.initState();
    _audioPlayer.onPositionChanged.listen((Duration duration) {
      setState(() {
        _position = duration;
      });
    });
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });}

    @override
    void dispose() {
      _audioPlayer.dispose();
      super.dispose();
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
                Navigator.pushReplacementNamed(
                    context, AppRoute.homeScreenMobile);
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    ApiController.getChapterInfo(chapterId: chapter.id)
                        .then((value) {
                      if (value != null) {
                        showModalBottomSheet(
                            enableDrag: true,
                            backgroundColor: Colors.transparent,
                            elevation: 8,
                            context: context,
                            builder: (BuildContext context) {
                              return BottomSheetWidget(
                                  chapterInfo: value, chapter: chapter);
                            });
                      } else {
                        print("error");
                      }
                    });
                  },
                  icon: Icon(
                    Icons.info,
                    color: AppColors.primeColor,
                  )),
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
            child: SizedBox(
              height: AppConsts.getHeight(context),
              width: AppConsts.getWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/background.png"),
                  SizedBox(
                    height: AppConsts.getHeight(context) * 0.1,
                  ),
                  Slider(
                    value: _sliderValue,
                    min: 0.0,
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                    onChangeEnd: seek,
                  ),
                  Text(
                    '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')} / ${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  ),
                  _middleWidget(context, chapter: chapter,isPlaying: _isPlaying),
                ],
              ),
            ),
          ));
    }

    void seek(double value) {
      _audioPlayer.seek(Duration(seconds: value.toInt()));
    
  }

  void _play({required ChapterModule chapter}) {
    ApiController.getAudio(id: 1, chapter_number: chapter.id).then((value) {
      if (value != null) {
        _audioPlayer.play(UrlSource(value));
      }
    });
    setState(() {
      _isPlaying = true;
    });
  }

  void _pause() {
    _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  _middleWidget(BuildContext context, {required ChapterModule chapter,required bool isPlaying}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.fast_rewind_outlined,
              color: AppColors.primeColor,
              size: 30,
            )),
        const SizedBox(
          width: 10,
        ),
        CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.primeColor,
          child: IconButton(
              onPressed: () {
                if (_isPlaying) {
                  _pause();
                } else {
                  _play(chapter: chapter);
                }
              },
              icon: Center(
                  child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ))),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.fast_forward_outlined,
              color: AppColors.primeColor,
              size: 30,
            ))
      ],
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
                margin:
                    EdgeInsets.only(top: AppConsts.getHeight(context) * 0.02),
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
}
