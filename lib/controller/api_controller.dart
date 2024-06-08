import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quran/model/ayah.dart';
import 'package:quran/model/chapter.dart';
import 'package:quran/model/chapter_info.dart';
import 'package:quran/utils/app_consts.dart';

class ApiController {
  static final Dio _dio = Dio();

  static Future<List<ChapterModule>?> getAllChapter() async {
    try {
      Response response = await _dio.get('${AppConsts.url}/chapters');

      if (response.data["chapters"] is List) {
        List<dynamic> chaptersJson = response.data["chapters"];
        List<ChapterModule> chapters = chaptersJson.map((json) {
          return ChapterModule.fromMap(json);
        }).toList();
        return chapters;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  static Future<ChapterInfo?> getChapterInfo({required chapterId}) async {
    try {
      Response response =
          await _dio.get('${AppConsts.url}/chapters/$chapterId/info');
      ChapterInfo chapterInfo =
          ChapterInfo.fromMap(response.data['chapter_info']);
      return chapterInfo;
    } on DioException catch (e) {
     if (kDebugMode) {
        print(e);
      }
      return null;
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  static Future<List<Ayah>?>? getChapterAyah({required int chapterId}) async {
    try {
      Map<String, dynamic> queryParams = {
        'chapter_number': chapterId,
      };
      Response response = await _dio.get('${AppConsts.url}/quran/verses/imlaei',
          queryParameters: queryParams);

      if (response.data["verses"] is List) {
        List<dynamic> chaptersJson = response.data["verses"];
        List<Ayah> chapters = chaptersJson.map((json) {
          return Ayah.fromMap(json);
        }).toList();
        return chapters;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  static Future<String?> getAudio({required int id,required int chapterNumber}) async {
    try {
      Response response =
          await _dio.get('${AppConsts.url}/chapter_recitations/$id/$chapterNumber');
      var chaptersJson = response.data['audio_file']['audio_url'];
      return chaptersJson;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
