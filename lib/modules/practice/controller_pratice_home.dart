import 'package:english_teacher_app/models/server_models.dart';
import 'package:english_teacher_app/services/yaml_config_service.dart';
import 'package:get/get.dart';

class ControllerPraticeHome extends GetxController {
  Rx<PracticeSumSerModel> practiceSumData = new Rx<PracticeSumSerModel>(null);
  Rx<List<PracticeLightSerModel>> pratices =
      new Rx<List<PracticeLightSerModel>>([]);

  ConfingService2 configService;
  @override
  void onInit() {
    configService = Get.find<ConfingService2>();
    //pratices.value.add( new PracticeLightSerModel(time: DateTime.now(), wordCount:32, mins: 3, correctRate: 3.3)  );
    getData();
    getPratices();
    super.onInit();
  }

  Future<void> getData() async {
    await Future.delayed(Duration(seconds: 1));
    practiceSumData.value = new PracticeSumSerModel(
        minutes: 3, wordCount: 3, lastPracticeCorrectRate: 3.8);
  }

  Future<void> getPratices() async {
    await Future.delayed(Duration(seconds: 3));
    pratices.value.add(new PracticeLightSerModel(
        time: DateTime.now(), wordCount: 32, mins: 3, correctRate: 3.3));
    pratices.update((val) {});
  }
}
