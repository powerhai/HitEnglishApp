import 'package:english_teacher_app/domain/event.dart';
import 'package:english_teacher_app/models/grade.dart';
import 'package:english_teacher_app/models/server_models.dart';
import 'package:english_teacher_app/services/login_service.dart';
import 'package:english_teacher_app/services/yaml_config_service.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MeController extends GetxController {
  List<PublisherSerModel> publishers = [];
  List<GradeModel> grades = [];

  var configService;
  var name = "".obs;
  var isLoggedIn = false.obs;

  String publisher = "";
  var sex = 0.obs;
  var sexString = "".obs;
  RxString gradeString = "".obs;
  RxString publisherString = "".obs;
  int grade = 1;
  RxString school = "".obs;
  Rx<DateTime> birthday = DateTime(2000).obs;
  List<SexSerModel> sexMap = [];

  EventBus eventBus;

  LoginService loginService;

  String get publisherString2 {
    if (publishers.length <= 0) return "";
    if (!publishers.any((element) => element.id == publisher)) return "";
    var v = publishers.firstWhere((e) => e.id == publisher).name;
    return v;
  }

  int get publisherIndex {
    return publishers.indexWhere((e) => e.id == publisher);
  }

  int get gradeIndex {
    return grades.indexWhere((e) => e.id == grade);
  }

  @override
  void onReady() {
    super.onReady();
   
  }

  @override
  void onInit() {
    configService = Get.find<ConfingService2>();
    loginService = Get.find<LoginService>();
    eventBus = Get.find<EventBus>();
    eventBus.on<UserLoggedInEvent>().listen((event) {
      if(!event.needRegister){
        this.isLoggedIn.value = true;
      }   this.isLoggedIn.value = true;
    });

    EasyLoading.show(status: 'loading...');

    name.value = "黄新睿";
    sex.value = 0;
    school.value = "实验学校";
    grade = 1;
    publisher = "";
    //birthday.value = DateTime.now();
    publishers = [PublisherSerModel(id: "sfsdf", name: "ok")];
    var gs = [
      GradeModel(id: 1, name: "abc", group: "a "),
      GradeModel(id: 3, name: "awerasd", group: "a ")
    ];
    grades = gs
        .map((p) => new GradeModel(id: p.id, name: p.name, group: ""))
        .toList();

    var ss = [
      SexSerModel(id: 1, name: "男"),
      SexSerModel(id: 2, name: "女"),
    ];
    sexMap = ss;

    EasyLoading.dismiss();

    super.onInit();
  }

Future<void> gotoLoginPage() async {
   await  Get.toNamed("Login");    
}
  void updateName(String name) {
    this.name.value = name;
  }

  void updateSchool(String school) {
    this.school.value = school;
  }

  void updatePublisher(int publisherIndex) {
    this.publisher = publishers[publisherIndex].id;
    if (publishers.length <= 0) {
      publisherString.value = "";
    } else {
      if (!publishers.any((element) => element.id == publisher)) {
        publisherString.value = "";
      } else {
        var v = publishers.firstWhere((e) => e.id == publisher).name;
        publisherString.value = v;
      }
    }
  }

  void updateGrade(int gradeId) {
    this.grade = gradeId;
    if (!grades.any((e) => e.id == grade)) {
      this.gradeString.value = "";
    } else {
      var g = grades.firstWhere((e) => e.id == this.grade);
      this.gradeString.value = g.name;
    }
  }

  void updateBirthday(DateTime dt) {
    this.birthday.value = dt;
  }

  void updateSex(int sexId) {
    this.sex.value = sexId;
    if (!sexMap.any((e) => e.id == sex.value)) {
      this.sexString.value = "";
    } else {
      var s = sexMap.firstWhere((e) => e.id == sex.value);
      this.sexString.value = s.name;
    }
  }
}
