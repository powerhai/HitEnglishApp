import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:english_teacher_app/common/dio_http_helper.dart';
import 'package:english_teacher_app/models/client_model.dart';
import 'package:english_teacher_app/models/server_models.dart';
import 'package:english_teacher_app/services/login_service.dart';
import 'package:get/get.dart';
import 'yaml_config_service.dart';

class PracticeService extends GetxService {
  bool _loaded = false;

  String _serverAddress;

  static const String ApiGetUserPractices = "practice/GetUserPractices";
  static const String ApiGetPractice = "practice/GetPractice";
  static const String ApiGetUserPracticeSum = "practice/GetUserPracticeSum";
  static const String ApiGetPracticeTexts = "practice/GetPracticeTexts";
  static const String ApiPostSavePractice = "practice/SavePractice";

  LoginService _loginService;

  Future<PracticeService> init() async {
    var config = Get.find<ConfingService2>();
    _serverAddress = config.serverBaseUrl;
    _loginService = Get.find<LoginService>();
    return this;
  }

  Future<List<PracticeArticleSerMoel>> getPracticeArticles() async {
    var dio = DioHelper.getDioObject();
    var uri = Uri.parse(
        '${this._serverAddress}${PracticeService.ApiGetPracticeTexts}');
    var res = await dio.getUri(uri,
        options: buildCacheOptions(Duration(minutes: 1),
            primaryKey: ApiGetPracticeTexts, maxStale: Duration(minutes: 1)));
    var rd = res.data as List;
    var ps = rd.map((v) => PracticeArticleSerMoel.fromJson(v)).toList();
    return ps;
  }

  Future<List<PracticeLightSerModel>> getUserPractices() async {
    var dio = DioHelper.getDioObject();
    var uri = Uri.parse(
        '${this._serverAddress}${PracticeService.ApiGetUserPractices}?userId=${_loginService.userId}');
    var res = await dio.getUri(uri,
        options: buildCacheOptions(Duration(minutes: 1),
            primaryKey: ApiGetUserPractices, maxStale: Duration(minutes: 1)));
    var rd = res.data as List;
    var ps = rd.map((v) => PracticeLightSerModel.fromJson(v)).toList();
    return ps;
  }

  Future<PracticeRichSerModel> getPractice(String practiceId) async {
    var dio = DioHelper.getDioObject();
    var uri = Uri.parse(
        '${this._serverAddress}${PracticeService.ApiGetPractice}?practiceId=${practiceId}');
    var res = await dio.getUri(uri,
        options: buildCacheOptions(Duration(minutes: 1),
            primaryKey: ApiGetPractice, maxStale: Duration(minutes: 1)));
    var ps = PracticeRichSerModel.fromJson(res.data);
    return ps;
  }

  Future<PracticeSumSerModel> getUserPracticeSum() async {
    var dio = DioHelper.getDioObject();
    var uri = Uri.parse(
        '${this._serverAddress}${PracticeService.ApiGetUserPracticeSum}?userId=${_loginService.userId}');
    var res = await dio.getUri(uri,
        options: buildCacheOptions(Duration(minutes: 1),
            primaryKey: ApiGetUserPracticeSum, maxStale: Duration(minutes: 1)));
    var ps = PracticeSumSerModel.fromJson(res.data);
    return ps;
  }

  Future savePractice(
      Duration timeSpan, double correctRate, List<WordPostModel> words) async {
    Map<String, dynamic> map = Map();
    map['minutes'] = timeSpan.inMinutes;
    map['correctRate'] = correctRate;
    map['words'] = words;

    var dio = DioHelper.getDioObject();
    var uri = Uri.parse(
        '${this._serverAddress}${PracticeService.ApiPostSavePractice}');
    var res = await dio.postUri(
      uri,
      options: Options(contentType: "application/json"),
      data: map,
    );
  }
}
