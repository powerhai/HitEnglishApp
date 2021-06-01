import 'package:english_teacher_app/models/grade.dart';
import 'package:english_teacher_app/models/server_models.dart';
import 'package:english_teacher_app/services/domain_service.dart';
import 'package:english_teacher_app/services/publisher_service.dart';
import 'package:english_teacher_app/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class VmMe extends ChangeNotifier {
  List<PublisherSerModel> publishers = [];
  List<GradeModel> grades = [];

  UserService userService;

  DomainService domainService;
  PublisherService publisherService;

  VmMe() {}
  List<SexSerModel> sexMap = [];

  String get sexString {
    if (!sexMap.any((e) => e.id == sex)) return "";
    var s = sexMap.firstWhere((e) => e.id == sex);
    return s.name;
  }

  String get publisherString {
    if (publishers.length <= 0) return "";
    if (!publishers.any((element) => element.id == publisher)) return "";
    var v = publishers.firstWhere((e) => e.id == publisher).name;
    return v;
  }

  int get publisherIndex {
    return publishers.indexWhere((e) => e.id == publisher);
  }

  String get gradeString {
    if (!grades.any((e) => e.id == grade)) return "";
    var g = grades.firstWhere((e) => e.id == this.grade);
    if (g == null) return "";
    return g.name;
  }

  int get gradeIndex {
    return grades.indexWhere((e) => e.id == grade);
  }

  String publisher = "";
  int sex = 0;
  int grade = 1;

  String name = "";
  String school = "";
  DateTime birthday;

  Future<AsyncSnapshot<bool>> init() async {
    domainService = await GetIt.instance.getAsync<DomainService>();
    publisherService = await GetIt.instance.getAsync<PublisherService>();

    userService = await GetIt.instance.getAsync<UserService>();

    var userModel = await userService.getUser();
    name = userModel.name;
    sex = 0;
    school = userModel.school;
    grade = 1;
    publisher = "";
    birthday = userModel.birthday;
    publishers = await publisherService.getAllPublishers();
    var gs = await domainService.getGradeList();
    grades = gs
        .map((p) => new GradeModel(id: p.id, name: p.name, group: ""))
        .toList();

    var ss = await domainService.getSexList();
    sexMap = ss;
    return new AsyncSnapshot<bool>.withData(ConnectionState.done, true);
  }

  void updateName(String name) {
    this.name = name;
    this.notifyListeners();
  }

  void updateSchool(String school) {
    this.school = school;
    this.notifyListeners();
  }

  void updatePublisher(int publisherIndex) {
    this.publisher = publishers[publisherIndex].id;
    this.notifyListeners();
  }

  void updateGrade(int gradeId) {
    this.grade = gradeId;
    this.notifyListeners();
  }

  void updateBirthday(DateTime dt) {
    this.birthday = dt;
    this.notifyListeners();
  }

  void updateSex(int sexId) {
    this.sex = sexId;
    this.notifyListeners();
  }
}
