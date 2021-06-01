import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:english_teacher_app/common/dio_http_helper.dart';
import 'package:english_teacher_app/models/server_models.dart';
import 'package:get/get.dart';

import 'yaml_config_service.dart';

class PublisherService extends GetxService {
  static const String ApiGetAllPublishers = "publisher/GetAllPublishers";

  bool _loaded = false;

  String _serverAddress;

  Future<PublisherService> init() async {
    await Future.delayed(Duration(milliseconds: 3));

    var config = Get.find<ConfingService2>();
    _serverAddress = config.serverBaseUrl;

    return this;
  }



  Future<List<PublisherSerModel>> getAllPublishers() async {
    await Future.delayed(Duration(milliseconds: 3));

    var dio = DioHelper.getDioObject();
    var uri = Uri.parse(
        '${this._serverAddress}${PublisherService.ApiGetAllPublishers}');

    var res = await dio.getUri(uri,
        options: buildCacheOptions(Duration(days: 30),
            primaryKey: ApiGetAllPublishers, maxStale: Duration(days: 30)));

    var rd = res.data as List;
    var ps = rd.map((v) => PublisherSerModel.fromJson(v)).toList();
    return ps;
  }
}
