import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:english_teacher_app/common/dio_http_helper.dart'; 
import 'package:english_teacher_app/models/server_models.dart'; 
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart'; 

import 'yaml_config_service.dart';

class WechatService extends GetxService { 
  String wxAppId = "";
  String wxUniversalLink = "";
  bool isSettingsLoaded = false;
  bool isWxApiRegisted = false;

  String _serverAddress;
  static const String ApiGetWechatSettings = "globalsettings/GetWechatSettings";
  Future<WechatService> init() async {
    var config = Get.find<ConfingService2>();
    _serverAddress = config.serverBaseUrl;
    return this;
  }

  Future<void> getWechatSettings() async {
    var dio = new Dio(BaseOptions(responseType: ResponseType.json));
    dio.interceptors.add(DioHelper.getCacheManager().interceptor);
    var uri = Uri.parse(
        '${this._serverAddress}${WechatService.ApiGetWechatSettings}');
    var res = await dio.getUri(uri,
        options: buildCacheOptions(Duration(days: 30),
            primaryKey: ApiGetWechatSettings, maxStale: Duration(days: 30)));
    var settings = WechatSettings.fromJson(res.data);
    wxAppId = settings.appId;
    wxUniversalLink = settings.universalLink;
  }

  Future<void> requestLoginWechat() async {
    if (isSettingsLoaded != true) {
      await getWechatSettings();
      isSettingsLoaded = true;
    }
    if (isWxApiRegisted != true) {
      registerWxApi(appId: wxAppId, universalLink: wxUniversalLink);
      isWxApiRegisted = true;
    }
    sendWeChatAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test");
  }
}
