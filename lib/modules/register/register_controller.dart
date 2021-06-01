import 'dart:io';

import 'package:camera/camera.dart';
import 'package:english_teacher_app/services/camera_service.dart';
import 'package:english_teacher_app/services/login_service.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class RegisterController extends GetxController {
  CameraService cameraService;
  LoginService loginService;
  RegisterController() {
    cameraService = Get.find();
    loginService = Get.find();
    cameraController = new CameraController(
        cameraService.cameras
            .firstWhere((e) => e.lensDirection == CameraLensDirection.front),
        ResolutionPreset.max);
  }

  var pageIndex = 0.obs;
  String photoFile = "";
  CameraController cameraController;
  var cameraIsReady = false.obs;

  @override
  Future<void> onInit() async {
    
    super.onInit();
  }
  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();
  Future<void> takePhoto() async {

     final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/Pictures/flutter_test';
      Directory dc = new Directory(dirPath);
      if (await dc.exists()) {
        dc.delete(recursive: true);
      }

      await new Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${timestamp()}.jpg';

      
    var file = await this.cameraController.takePicture();
    //var bytes = await file.readAsBytes();
    photoFile = file.path;
    loginService.registerUser("Haiser", "实验学校", file.path);
  }

  void nextPage() {
    pageIndex.value += 1;
  }

  @override
  void onClose() { 
    super.onClose();
    cameraController.dispose();
  }

  @override
  Future<void> onReady() async {
    await cameraController.initialize();
     cameraIsReady.value = true;
    super.onReady();
  }
}
