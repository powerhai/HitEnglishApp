import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:english_teacher_app/common/dio_http_helper.dart';
import 'package:english_teacher_app/domain/enum_difination.dart';
import 'package:english_teacher_app/models/server_models.dart';
import 'package:get/get.dart';

import 'yaml_config_service.dart';

class UserService extends GetxService   {
  static const String ApiGetUser = "user/GetUserProfile";

  String _serverAddress;

  Future<UserService> init() async {
    var config = Get.find<ConfingService2>();
    _serverAddress = config.serverBaseUrl;
    return this;
  }

  Future<UserSerModel> getUser() async {
    var dio = DioHelper.getDioObject();
    var uri = Uri.parse('${this._serverAddress}${UserService.ApiGetUser}');

    var res = await dio.getUri(uri,
        options: buildCacheOptions(Duration(days: 30),
            primaryKey: ApiGetUser, maxStale: Duration(days: 30)));

    var ps = UserSerModel.fromJson(res.data);
    ps.sex = Sex.Female;

    ps.grade = Grade.Primary6;
    return ps;
  }

 
}
