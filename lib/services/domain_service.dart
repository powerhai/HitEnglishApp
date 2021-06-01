import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:english_teacher_app/common/dio_http_helper.dart';
import 'package:english_teacher_app/models/server_models.dart';
import 'package:get/get.dart';

import 'yaml_config_service.dart';

class DomainService extends GetxService  {
  static const String ApiGetGradeList = "domain/GetGradeList";
  static const String ApiGetSexList = "domain/GetSexList";

  String _serverAddress;

  Future<DomainService> init() async {
    var config = Get.find<ConfingService2>();
    _serverAddress = config.serverBaseUrl;
    return this;
  }

  Future<List<GradeSerModel>> getGradeList() async {
    var dio = DioHelper.getDioObject();
    var uri =
        Uri.parse('${this._serverAddress}${DomainService.ApiGetGradeList}');

    var res = await dio.getUri(uri,
        options: buildCacheOptions(Duration(days: 30),
            primaryKey: ApiGetGradeList, maxStale: Duration(days: 30)));

    var rd = res.data as List;
    var ps = rd.map((v) => GradeSerModel.fromJson(v)).toList();
    return ps;
  }

  Future<List<SexSerModel>> getSexList() async {
    var dio = DioHelper.getDioObject();
    var uri = Uri.parse('${this._serverAddress}${DomainService.ApiGetSexList}');

    var res = await dio.getUri(uri,
        options: buildCacheOptions(Duration(days: 30),
            primaryKey: ApiGetSexList, maxStale: Duration(days: 30)));

    var rd = res.data as List;
    var ps = rd.map((v) => SexSerModel.fromJson(v)).toList();
    return ps;
  }
}
