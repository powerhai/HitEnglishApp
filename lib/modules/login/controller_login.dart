import 'package:english_teacher_app/domain/event.dart';
import 'package:english_teacher_app/services/login_service.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginService loginService;

  EventBus eventBus;

  LoginController() {}

  @override
  void onInit() {
    super.onInit();
    loginService = Get.find<LoginService>();
    eventBus = Get.find<EventBus>();
    eventBus.on<UserLoggedInEvent>().listen((event) {
      if (event.needRegister == false) {
        Get.back();
      } else {
        //Get.back();
        Get.offNamed("Register");
      }
      EasyLoading.dismiss();
    });
  }

  void login() {
    loginService.login();
    EasyLoading.show(status: 'loading...');

    //  Get.back();
  }
}
