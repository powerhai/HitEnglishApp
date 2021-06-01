import 'package:english_teacher_app/domain/config_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:yaml/yaml.dart';

import 'package:get/get.dart';

class ConfigService {
  static const yamlConfigFile = "resources/config.yaml";
  SharedPreferences prefs;
  bool _isLoaded = false;
  bool _isCacheToSP = false;
  String baiduBaseUrl = "";
  String baiduClientId = "";
  String baiduClientSecret = "";
  String serverBaseUrl = "";

  String wxAppId = "";
  String wxUniversalLink = "";

  Future<ConfigService> init() async {
    this.prefs = await SharedPreferences.getInstance();
    if (this.prefs.containsKey(ConfigKey.isConfigCached)) {
      await loadFromSp();
    } else {
      await loadFromYaml();
      await cacheToSp();
    }
    _isLoaded = true;
    // GetIt.instance.signalReady(this);

    return this;
  }

 

  Future<void> loadFromYaml() async {
    var str = await rootBundle.loadString(yamlConfigFile);
    var doc = loadYaml(str);
    baiduBaseUrl = doc[ConfigKey.baiduBaseUrl];
    baiduClientId = doc[ConfigKey.baiduClientId];
    baiduClientSecret = doc[ConfigKey.baiduClientSecret];
    serverBaseUrl = doc[ConfigKey.serverBaseUrl];
    wxUniversalLink = doc[ConfigKey.wxUniversalLink];
    wxAppId = doc[ConfigKey.wxAppId];
  }

  Future<void> loadFromSp() async {
    baiduBaseUrl = prefs.getString(ConfigKey.baiduBaseUrl);
    baiduClientId = prefs.getString(ConfigKey.baiduClientId);
    baiduClientSecret = prefs.getString(ConfigKey.baiduClientSecret);
    serverBaseUrl = prefs.getString(ConfigKey.serverBaseUrl);
    wxAppId = prefs.getString(ConfigKey.wxAppId);
    wxUniversalLink = prefs.getString(ConfigKey.wxUniversalLink);
  }

  Future<void> cacheToSp() async {
    prefs.setString(ConfigKey.baiduBaseUrl, baiduBaseUrl);
    prefs.setString(ConfigKey.baiduClientId, baiduClientId);
    prefs.setString(ConfigKey.baiduClientSecret, baiduClientSecret);
    prefs.setBool(ConfigKey.isConfigCached, true);
    prefs.setString(ConfigKey.serverBaseUrl, serverBaseUrl);
    prefs.setString(ConfigKey.wxAppId, wxAppId);
    prefs.setString(ConfigKey.wxUniversalLink, wxUniversalLink);
  }
}

class ConfingService2 extends GetxService {
  static const yamlConfigFile = "resources/config.yaml";
  SharedPreferences prefs;
  bool _isLoaded = false;
  bool _isCacheToSP = false;
  String baiduBaseUrl = "";
  String baiduClientId = "";
  String baiduClientSecret = "";
  String serverBaseUrl = "";

  String wxAppId = "";
  String wxUniversalLink = "";

  Future<ConfingService2> init() async {
    this.prefs = await SharedPreferences.getInstance();
    if (this.prefs.containsKey(ConfigKey.isConfigCached)) {
      await loadFromSp();
    } else {
      await loadFromYaml();
      await cacheToSp();
    }
    _isLoaded = true;

    return this;
  }

  Future<void> loadFromYaml() async {
    var str = await rootBundle.loadString(yamlConfigFile);
    var doc = loadYaml(str);
    baiduBaseUrl = doc[ConfigKey.baiduBaseUrl];
    baiduClientId = doc[ConfigKey.baiduClientId];
    baiduClientSecret = doc[ConfigKey.baiduClientSecret];
    serverBaseUrl = doc[ConfigKey.serverBaseUrl];
    wxUniversalLink = doc[ConfigKey.wxUniversalLink];
    wxAppId = doc[ConfigKey.wxAppId];
  }

  Future<void> loadFromSp() async {
    baiduBaseUrl = prefs.getString(ConfigKey.baiduBaseUrl);
    baiduClientId = prefs.getString(ConfigKey.baiduClientId);
    baiduClientSecret = prefs.getString(ConfigKey.baiduClientSecret);
    serverBaseUrl = prefs.getString(ConfigKey.serverBaseUrl);
    wxAppId = prefs.getString(ConfigKey.wxAppId);
    wxUniversalLink = prefs.getString(ConfigKey.wxUniversalLink);
  }

  Future<void> cacheToSp() async {
    prefs.setString(ConfigKey.baiduBaseUrl, baiduBaseUrl);
    prefs.setString(ConfigKey.baiduClientId, baiduClientId);
    prefs.setString(ConfigKey.baiduClientSecret, baiduClientSecret);
    prefs.setBool(ConfigKey.isConfigCached, true);
    prefs.setString(ConfigKey.serverBaseUrl, serverBaseUrl);
    prefs.setString(ConfigKey.wxAppId, wxAppId);
    prefs.setString(ConfigKey.wxUniversalLink, wxUniversalLink);
  }
}
