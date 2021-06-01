import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraService extends GetxService {
  List<CameraDescription> cameras = [];

  Future<CameraService> init() async {
    cameras = await availableCameras();
    return this;
  }
}
