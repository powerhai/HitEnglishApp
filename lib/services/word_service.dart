import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:english_teacher_app/common/dio_http_helper.dart';
import 'package:english_teacher_app/models/server_models.dart';
import 'package:get/get.dart';

import 'yaml_config_service.dart';

class WordService extends GetxService {
  String _serverAddress;

  static const String ApiGetWord = "word/GetWord";

  Future<WordService> init() async {
    var config = Get.find<ConfingService2>();
    _serverAddress = config.serverBaseUrl;
    return this;
  }

  Future<WordSerModel> getWord(String word) async {
    var dio = DioHelper.getDioObject();
    var uri = Uri.parse(
        '${this._serverAddress}${WordService.ApiGetWord}?word=$word');
    var res = await dio.getUri(uri,
        options: buildCacheOptions(Duration(minutes: 1),
            primaryKey: ApiGetWord,
            subKey: word,
            maxStale: Duration(minutes: 1)));
    var ps = WordSerModel.fromJson(res.data);
    return ps;
  }
}
