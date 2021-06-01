import 'dart:async';
 
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart'; 
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DiscoveryController extends GetxController {
  FormGroup form = new FormGroup({
    "name": FormControl<String>(value: "性名", validators: [Validators.required]),
    "birthday": FormControl<DateTime>(
        value: DateTime(2010, 1, 1), validators: [Validators.required]),
    "sex": FormControl<String>(validators: [Validators.required]),
    "grade": FormControl<String>(validators: [Validators.required]),
    "school": FormControl<String>(value: "", validators: [Validators.required]),
  });

  Map<String, Object> _loationResult;
  BaiduLocation _baiduLocation; // 定位结果
  StreamSubscription<Map<String, Object>> _locationListener;
  LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();
 
 

  @override
  Future<void> onInit() async {
    super.onInit();

    try {
      //var latlng = await Gps.currentGps();
      // print(latlng.lat);
      // print(latlng.lng);

      _locationPlugin.requestPermission();
 

      _locationListener = _locationPlugin
          .onResultCallback()
          .listen((Map<String, Object> result) {
        _baiduLocation = BaiduLocation.fromMap(result);

        _locationPlugin.stopLocation();
        _locationListener.cancel();
      });

       _setLocOption();
      _locationPlugin.startLocation();


    } catch (e) {}

 
  }
 
  void _setLocOption() {
    /// android 端设置定位参数
    BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
    androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
    androidOption.setIsNeedAltitude(true); // 设置是否需要返回海拔高度信息
    androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
    androidOption.setIsNeedLocationPoiList(true); // 设置是否需要返回周边poi信息
    androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
    androidOption.setOpenGps(true); // 设置是否需要使用gps
    androidOption.setLocationMode(LocationMode.Hight_Accuracy); // 设置定位模式
    androidOption.setScanspan(0); // 设置发起定位请求时间间隔


    Map androidMap = androidOption.getMap();

    BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
    iosOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    iosOption.setBMKLocationCoordinateType("BMKLocationCoordinateTypeBMK09LL"); // 设置返回的位置坐标系类型
    iosOption.setActivityType("CLActivityTypeAutomotiveNavigation"); // 设置应用位置类型
    iosOption.setLocationTimeout(10); // 设置位置获取超时时间
    iosOption.setDesiredAccuracy("kCLLocationAccuracyBest");  // 设置预期精度参数
    iosOption.setReGeocodeTimeout(10); // 设置获取地址信息超时时间
    iosOption.setDistanceFilter(100); // 设置定位最小更新距离
    iosOption.setAllowsBackgroundLocationUpdates(true); // 是否允许后台定位
    iosOption.setPauseLocUpdateAutomatically(true); //  定位是否会被系统自动暂停

    Map iosMap = iosOption.getMap();

    _locationPlugin.prepareLoc(androidMap, iosMap);
  }

  void goLogin() {
    // Get.toNamed("Login");
    print(form.value);
    form.printError();
  }
}
