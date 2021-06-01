import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  HomeController();

  void setCurrentPageIndex(int index) {
    currentIndex.value = index;
  }
}
