import 'dart:convert';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:english_teacher_app/common/dio_http_helper.dart';
import 'package:english_teacher_app/domain/event.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:dio/dio.dart' as da;
import 'yaml_config_service.dart';

class LoginService extends GetxService {
  String _serverAddress;
  static const String WechatApiAccessToken =
      "https://api.weixin.qq.com/sns/oauth2/access_token";
  static const String FingerAuthApi = "Authentication/Login";
  static const String FingerRegisterApi = "User/RegisterUser";

  bool isUserLoggedIn = false;

  static const String ApiGetUser = "user/LoginUser";
  String userId;

  String wechatCode = "";
  bool isLoggedIn = false;

  ConfingService2 config;

  EventBus eventBus;

  Future<LoginService> init() async {
    config = Get.find<ConfingService2>();
    eventBus = Get.find<EventBus>();
    _serverAddress = config.serverBaseUrl;
    return this;
  }

  @override
  void onInit() {
    getUserId();

    fluwx.weChatResponseEventHandler.listen((event) async {
      if (event.errCode == 0) {
        var authEvent = event as WeChatAuthResponse;
        wechatCode = authEvent.code;
        var rev = await loginWebSite();

        eventBus.fire(UserLoggedInEvent(this.userId, rev.needRegister));
      }
    });
  }

  void login() {
    wechatAuth();
  }

  Future<WebSiteLoginResponse> loginWebSite() async {
    var dio = DioHelper.getDioObject();
    var res = await dio
        .get('${this._serverAddress}${FingerAuthApi}', queryParameters: {
      "code": this.wechatCode,
    });

    var resData = WebSiteLoginResponse.fromMap(res.data);
    return resData;
  }

  Future<void> registerUser(
      String name, String school, String imageFilePath) async {
    var dio = DioHelper.getDioObject();
    var formData = da.FormData.fromMap({
      'name': name,
      'school': school,
      'file':
          await da.MultipartFile.fromFile(imageFilePath, filename: 'img.jpg'),
    });
    var response = await dio.post('${this._serverAddress}$FingerRegisterApi',
        data: formData);
  }

  wechatAuth() {
    fluwx
        .sendWeChatAuth(scope: "snsapi_userinfo", state: 'wechat_sdk_demo_test')
        .then((value) {
      print(value);
    }).catchError((e) {
      print('weChatLogin e $e');
    });
  }

  Future getUserId() async {
    var dio = DioHelper.getDioObject();
    var uri = Uri.parse('${this._serverAddress}${LoginService.ApiGetUser}');
    try {
      var res = await dio.getUri(uri,
          options: buildCacheOptions(Duration(minutes: 1),
              primaryKey: ApiGetUser, maxStale: Duration(minutes: 1)));
      this.userId = res.data;
    } catch (e) {}
    isLoggedIn = true;
  }
}

class WebSiteLoginResponse {
  final String unionId;
  final bool needRegister;
  WebSiteLoginResponse.fromMap(Map map)
      : unionId = map["unionId"],
        needRegister = map["needRegister"];
}

class WeChatAccessTokenResponse {
  final int errCode;
  final String errStr;
  final String accessToken;
  final int expiresIn;
  final String refreshToken;
  final String openId;
  final String scope;

  bool get isSuccessful => errCode == 0;
  WeChatAccessTokenResponse.fromMap(Map map)
      : errCode = map.containsKey("errcode") ? map["errcode"] : 0,
        errStr = map["errmsg"],
        accessToken = map["access_token"],
        expiresIn = map["expires_in"],
        refreshToken = map["refresh_token"],
        openId = map["openid"],
        scope = map["scope"];
}
