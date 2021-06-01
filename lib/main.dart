import 'package:english_teacher_app/modules/home/page_home.dart';
import 'package:english_teacher_app/modules/login/controller_login.dart'; 
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
import 'common/dio_http_helper.dart';
import 'modules/discovery/ctr_discovery.dart';
import 'modules/me/controller_me.dart';
import 'modules/login/page_login.dart';
import 'modules/practice/controller_pratice_home.dart';
import 'modules/register/register_controller.dart';
import 'modules/register/register_page.dart'; 
import 'modules/home/controller_home.dart';
import 'services/article_service.dart';
import 'services/baidu_ai_service.dart';
import 'services/camera_service.dart';
import 'services/domain_service.dart';
import 'services/event_bus_service.dart';
import 'services/login_service.dart';
import 'services/practice_service.dart';
import 'services/publisher_service.dart';
import 'services/wechat_service.dart';
import 'services/yaml_config_service.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

initFluwx() async {
  await fluwx.registerWxApi(
      appId: "wx93a21602a886e970",
      doOnAndroid: true,
      doOnIOS: true,
      universalLink: "ios 需要");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.Init();
  await initFluwx();
  await registerServices();
  registerControllers();
  runApp(MyApp());
}

void registerControllers() {
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => MeController());
  Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
  Get.lazyPut(() => ControllerPraticeHome());
  Get.lazyPut(() => DiscoveryController());
  Get.lazyPut(() => RegisterController());
}

Future<void> registerServices() async {
  Get.put<EventBus>(EventBus());
  await Get.putAsync(() => ConfingService2().init());
  await Get.putAsync(() => EventBusService().init());
  await Get.putAsync(() => LoginService().init());
  await Get.putAsync(() => ArticleService().init());
  await Get.putAsync(() => DomainService().init());
  await Get.putAsync(() => BaiduAIService().init());
  await Get.putAsync(() => PracticeService().init());
  await Get.putAsync(() => PublisherService().init());
  await Get.putAsync(() => WechatService().init());
  await Get.putAsync(() => CameraService().init());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'English Teacher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageHome(), // PageHome( title: "okkoo"),
      getPages: [
        GetPage(name: "Home", page: () => PageHome()),
        GetPage(name: "Login", page: () => PageLogin()),
        //GetPage(name: "TypeWords", page: () => PageTypeWords()),
        GetPage(name: "Register", page: () => RegisterPage()),
      ], 
       
    );
  }
}
