
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quran/controller/api_controller.dart';
import 'package:quran/model/chapter.dart';
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
  final AudioPlayer _audioPlayer = AudioPlayer();
  double _sliderValue = 0.0;
  bool _isPlaying = false;
  Duration _duration = const Duration();
  Duration _position = const Duration();
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
                        if (kDebugMode) {
        print("Error");
      }
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
    ApiController.getAudio(id: 1, chapterNumber: chapter.id).then((value) {
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

 }
