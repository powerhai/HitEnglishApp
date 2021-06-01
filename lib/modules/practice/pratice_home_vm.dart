import 'package:english_teacher_app/models/practice.dart';
import 'package:english_teacher_app/models/server_models.dart';
import 'package:english_teacher_app/services/login_service.dart';
import 'package:english_teacher_app/services/practice_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'package:get/get.dart';

class VmPraticeHome extends ChangeNotifier {
  PracticeService practiceService;

  LoginService loginService;
  bool isUserLoggedIn = false;
  VmPraticeHome() {}
  List<PracticeLightSerModel> pratices = [];

  PracticeSumSerModel practiceSumData;

  Future<AsyncSnapshot<bool>> init() async {
    practiceService = await GetIt.instance.getAsync<PracticeService>();
    loginService = await GetIt.instance.getAsync<LoginService>();
    isUserLoggedIn = loginService.isUserLoggedIn;
    pratices = await practiceService.getUserPractices();
    practiceSumData = await practiceService.getUserPracticeSum();

    return new AsyncSnapshot<bool>.withData(ConnectionState.done, true);
  }
}

