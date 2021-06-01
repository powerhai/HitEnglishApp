import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class DioHelper {
  static Dio dio;
  static void Init() {
    dio = new Dio(BaseOptions(responseType: ResponseType.json));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };

    dio.interceptors.add(DioHelper.getCacheManager().interceptor);
    dio.interceptors.add(CookieManager(cookieJar));
  }

  static Map<String, DioCacheManager> _managers =
      new Map<String, DioCacheManager>();

  static DioCacheManager getCacheManager({String baseUrl = "system"}) {
    if (!_managers.containsKey(baseUrl)) {
      var mg = new DioCacheManager(CacheConfig(baseUrl: baseUrl));
      _managers[baseUrl] = mg;
    }
    return _managers[baseUrl];
  }

  static CookieJar cookieJar = CookieJar();

  static Dio getDioObject() {
    return dio;
  }
}
