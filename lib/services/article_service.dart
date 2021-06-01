 
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:english_teacher_app/common/dio_http_helper.dart';
import 'package:english_teacher_app/models/server_models.dart'; 
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'yaml_config_service.dart'; 

class ArticleService extends GetxService {
  bool _loaded = false;

  String _serverAddress;

  static const String ApiGetText = "Text/GetText";
  static const int GetTextCacheMinutes = 3;

  var config;

  Future<ArticleService> init() async {
     config = Get.find<ConfingService2>();
    _serverAddress = config.serverBaseUrl; 
    return this;
  }

  Future<TextSerModel> getArticle(String id) async {
    var dio = DioHelper.getDioObject();
    var uri = Uri.parse(
        '${this._serverAddress}${ArticleService.ApiGetText}?textId=${id}');
    var res = await dio.getUri(uri,
        options: buildCacheOptions(Duration(minutes: GetTextCacheMinutes),
            primaryKey: ApiGetText,
            subKey: id,
            maxStale: Duration(minutes: 1)));
    var ps = TextSerModel.fromJson(res.data);
    return ps;
  }
}
