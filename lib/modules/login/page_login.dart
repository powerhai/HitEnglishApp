import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'controller_login.dart';

class PageLogin extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: SafeArea(
          child: FlutterEasyLoading(
              child: TextButton(
            child: Text("Login"),
            onPressed: () => {this.controller.login()},
          )),
        ));
  }
}
